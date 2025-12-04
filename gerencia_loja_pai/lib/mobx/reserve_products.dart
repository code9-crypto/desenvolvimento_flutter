import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_loja_pai/datas/products_data.dart';
import 'package:mobx/mobx.dart';

part 'reserve_products.g.dart';

class ReserveProducts = _ReserveProducts with _$ReserveProducts;

abstract class _ReserveProducts with Store{
  //CONSTANTES
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @action
  void reservar(ProductData produto, String userID, BuildContext context){
    firestore.collection("users").doc(userID).collection("carrinho").add(
      {
        "name" : produto.nome,
        "img" : produto.imgUrl,
        "price" : produto.price
      }
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Adicionado ao carrinho com sucesso!!!"),
        backgroundColor: Colors.green,
      )
    );
  }

}