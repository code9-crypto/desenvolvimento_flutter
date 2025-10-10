import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ProductsBloc extends BlocBase{

  //VARIAVEIS
  late String categoryId;
  late DocumentSnapshot? product;

  //CONTROLLERS
  final dataController = BehaviorSubject();
  final loadingController = BehaviorSubject();

  //STREAM
  Stream get outData => dataController.stream;
  Stream get outLoading => loadingController.stream;

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

  //ESSES MÉTODOS SÃO RESPONSÁVEIS POR PEGAR OS VALORES DOS CAMPOS( NA CLASSE PAI PRODUCT_SCREEN ), SALVANDO NO unsavedData PARA DEPOIS SALVAR NO FIREBASE
  void saveTitle(String? title){
    unsavedData["title"] = title;
  }
  void saveDescription(String? description){
    unsavedData["description"] = description;
  }
  void savePrice(String? price){
    unsavedData["price"] = double.parse(price!);
  }
  void saveImages(List? images){
    unsavedData["images"] = images;
  }

  //Salvando todos os dados no banco
  Future<bool> savePrdBanco() async {
    loadingController.sink.add(true);

    await Future.delayed(Duration(seconds: 5));

    loadingController.sink.add(false);
    return true;
  }

}