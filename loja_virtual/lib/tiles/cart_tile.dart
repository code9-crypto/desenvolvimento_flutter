import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';

import '../models/cart_model.dart';

//ESTA CLASSE SERÁ RESPONSÁVEL POR MOSTRAR AS INFORMAÇÕES DE CADA ITEM NO CARRINHO
class CartTile extends StatelessWidget {
  //***VARIAVEIS***
  CartProduct? cProduct;

  //***CONSTRUTOR***
  CartTile(this.cProduct);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: cProduct!.pData == null
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("products")
                    .doc(cProduct?.category)
                    .collection("itens")
                    .doc(cProduct?.pid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    cProduct!.pData = ProductData.fromData(
                        snapshot.data as DocumentSnapshot<Object?>);
                    return _buildContent(context);
                  } else {
                    return Container(
                      height: 70.0,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                })
            : _buildContent(context));
  }

  //***FUNÇÕES***

  //Esta função está retornando um widget que será para a exibição dos dados no carrinho
  Widget _buildContent(BuildContext context) {
    //Esta Row é para deixar os itens alinhados um ao lado do outro
    return Row(
      children: [
        //Esse Container é para a imagem que irá aparecer
        Container(
          padding: EdgeInsets.all(8.0),
          width: 120.0,
          child: Image.network(
            cProduct?.pData?.images[0],
            fit: BoxFit.cover,
          ),
        ),
        //Este Expanded é para ocupar o máximo de espaço disponível
        Expanded(
          //Este Container é para usar o comando padding com intuito de deixar o espaçamento interno
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cProduct!.pData!.title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                ),
                Text(
                  "Tamanho: ${cProduct!.size}",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  "R\$ ${cProduct!.pData!.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  //este parâmetro nomeado faz com que os itens desta Row fiquem com espaçamento igualmente
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: cProduct!.quantity! > 1 ? (){
                        CartModel.of(context).decProduct(cProduct!);
                      } : null, //Aqui nesta veficação, caso a quantidade seja maior que 1, então o botão será habilitado para ser clicável; caso não, receberá null e ficará desabilitado
                        icon: Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                    ),
                    Text(cProduct!.quantity.toString()),
                    IconButton(
                      onPressed: (){
                        CartModel.of(context).incProduct(cProduct!);
                      },
                      icon: Icon(Icons.add, color: Theme.of(context).primaryColor)
                    ),
                    TextButton(
                      onPressed: (){
                        CartModel.of(context).removeCartItem(cProduct!);
                      },
                      child: Text("Remover", style: TextStyle(color: Colors.grey.shade500),),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
