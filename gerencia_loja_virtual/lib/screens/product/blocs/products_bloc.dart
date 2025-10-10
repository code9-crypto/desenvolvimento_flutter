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
  final createdController = BehaviorSubject();

  //STREAM
  Stream get outData => dataController.stream;
  Stream get outLoading => loadingController.stream;
  Stream get outCreated => createdController.stream;

  //MAPS
  Map<String, dynamic> unsavedData = {};

  //CONSTRUTOR
  ProductsBloc(super._state, {required this.categoryId, this.product}){
    if( product != null ){
      unsavedData = Map.of(product?.data() as Map<String, dynamic>); //aqui está copiando os dados que veio dentro da variavel product para variavel unsavedData
      unsavedData["images"] = List.of(product?.get("images"));
      unsavedData["sizes"] = List.of(product?.get("sizes"));

      createdController.sink.add(true);
    } else {
      unsavedData = {
        "title" : null,
        "description" : null,
        "price" : null,
        "images" : [],
        "sizes" : []
      };

      createdController.sink.add(false);
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

    try{
      if( product != null ){
        await uploadImages(product!.id);
        await product!.reference.update(unsavedData);
      }else{
        DocumentReference dr = await FirebaseFirestore.instance.collection("products").doc(categoryId).
          collection("items").add(Map.from(unsavedData)..remove("images"));
        await uploadImages(dr.id);
        await dr.update(unsavedData);
      }

      createdController.sink.add(true);
      loadingController.sink.add(false);
      return true;
    } catch(e){
      loadingController.sink.add(true);
      return false;
    }
  }

  //Salvando imagens no firebase; OBS.: essa função não funcionará aqui porque ela salva no CloudFireStore o qual não temos acesso por ser paga
  Future uploadImages(String prdId) async {
    for( int i = 0; i < unsavedData["images"].length; i++ ) {
      if (unsavedData["images"][i] is String) continue;

      /*StorageUploadTask uploadTask = FirebaseStorage.instance.ref().child(
          categoryId).
      child(prdId).child(DateTime
          .now()
          .millisecondsSinceEpoch
          .toString()).
      putFile(unsavedData["images"][i]);


      StorageTaskSnapshot s = await uploadTask.onComplete;
      String downloadUrl = await s.ref.getDownloadURL();

      unsavedData["images"][i] = downloadUrl;*/
    }
  }

  //Deletando o produto do banco
  void deleteProduct(){
    product!.reference.delete();
  }

}