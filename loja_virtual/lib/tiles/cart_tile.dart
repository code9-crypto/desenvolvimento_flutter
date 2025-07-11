import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';

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
      child: cProduct!.pData == null ?
        FutureBuilder(
          future: FirebaseFirestore.instance.collection("products").doc(cProduct?.category).collection("itens").doc(cProduct?.pid).get(),
          builder: (context, snapshot){
            if( snapshot.hasData ){
              cProduct!.pData = ProductData.fromData(snapshot.data as DocumentSnapshot<Object?>);
              return _buildContent();
            }else{
              return Container(
                height: 70.0,
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              );
            }
          }
        ) :
        _buildContent()
    );
  }

  Widget _buildContent(){

  }
}
