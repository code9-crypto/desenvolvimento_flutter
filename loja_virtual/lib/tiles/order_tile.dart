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
}
