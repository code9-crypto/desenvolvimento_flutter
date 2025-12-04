import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{

  //ATRIBUTOS
  late String nome;
  late String imgUrl;
  late double price;
  late int qtd;

  //CONSTRUTOR
  ProductData(DocumentSnapshot snapshot){
    nome = snapshot.get("nome");
    imgUrl = snapshot.get("image");
    price = snapshot.get("price");
    qtd = snapshot.get("quantidade");
  }

}