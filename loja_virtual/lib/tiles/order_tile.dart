import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {

  final String orderID;

  OrderTile(this.orderID);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>( //Este contrutor StreamBuilder ficará "escutando" em tempo real as alterações no banco de dados; quando houver modificação os widgets da tela serão modificados
          stream: FirebaseFirestore.instance.collection("orders").doc(orderID).snapshots(),//para obter respostas em tempo real do banco, então a codificação é esta(final snapshot())
          builder: (context, snapshot){
            if( !snapshot.hasData ){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{

              int status = snapshot.data!["status"];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Código do pedido: ${snapshot.data!.id}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    _buildProductsText(snapshot.data as DocumentSnapshot<Object?>)
                  ),
                  SizedBox(height: 4.0,),
                  Text(
                    "Status do pedido:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCircle("1", "Preparação", status, 1),
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey.shade500,
                      ),
                      _buildCircle("2", "Transporte", status, 2),
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey.shade500,
                      ),
                      _buildCircle("3", "Entrega", status, 3)
                    ],
                  )
                ],
              );
            }
          }
        ),
      ),
    );
  }

  //****FUNÇÕES****

  //Esta função está retornando os dados corpo do pedido
  String _buildProductsText(DocumentSnapshot snap){
    String text = "Descrição:\n";
    for( LinkedHashMap p in snap.get("products") ){
      text += "${p["quantity"]} x ${p["product"]["title"]} (R\$ ${p["product"]["price"].toStringAsFixed(2)})\n";
    }
    text += "Total: R\$ ${snap.get("totalPrice").toStringAsFixed(2)}";

    return text;
  }

  //Esta função está criando as bolinhas referentes ao acompanhamento do pedido
  Widget _buildCircle(String title, String subTitle, int status, int thisStatus){
    Color backColor;
    Widget child;

    //Se o status(esse valor que vem do banco) for menor que thisStatus(atribuido manualmente por parâmetro), as bolinhas(com status maior) ficaram com fundo cinza e com o texto que veio como parâmetro
    if( status < thisStatus ){
      backColor = Colors.grey.shade500;
      child = Text(title, style: TextStyle(color: Colors.white),);
    }
    //Se o status(esse valor que vem do banco) for igual ao thisStatus(atribuido manualmente por parâmetro), a bolinha(atual) ficará com fundo azul, o texto e circularProgress em volta girando
    else if( status == thisStatus ){
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          ],
      );
    }
    //Se o status(esse valor que vem do banco) for maior que thisStatus(atribuido manualmente por parâmetro), a bolinha(onde thisStatus < status) ficará com fundo verde e ícone check branco
    else{
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }

    //Aqui retorna uma coluna que terá uma estrutura vertical com a bolinha e o texto embaixo
    return Column(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subTitle)
      ],
    );
  }
}
