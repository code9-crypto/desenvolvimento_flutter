import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{

  //ATRIBUTOS
  late String nome;
  late String imgUrl;

  //CONSTRUTOR
  ProductData(DocumentSnapshot snapshot){
    nome = snapshot.get("nome");
    imgUrl = snapshot.get("image");
  }

}