import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ProductsBloc extends BlocBase{

  //VARIAVEIS
  late String categoryId;
  late DocumentSnapshot? product;

  //CONTROLLERS
  final dataController = BehaviorSubject();

  //STREAM
  Stream get outData => dataController.stream;

  //MAPS
  Map<String, dynamic> unsavedData = {};

  //CONSTRUTOR
  ProductsBloc(super._state, {required this.categoryId, this.product}){
    if( product != null ){
      unsavedData = Map.of(product?.data() as Map<String, dynamic>); //aqui está copiando os dados que veio dentro da variavel product para variavel unsavedData
      unsavedData["images"] = List.of(product?.get("images"));
      unsavedData["sizes"] = List.of(product?.get("sizes"));
    } else {
      unsavedData = {
        "title" : null,
        "description" : null,
        "price" : null,
        "images" : [],
        "sizes" : []
      };
    }

    dataController.sink.add(unsavedData);
  }

}