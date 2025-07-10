import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartProduct{

  String? cid;

  String? category;
  String? pid;

  int? quantity;
  String? size;

  ProductData? pData;

  CartProduct();

  //Construtor que pega os dados do banco e passa para o formato da classe
  CartProduct.fromDocument(DocumentSnapshot doc){
    cid = doc.id;
    category = doc.get("category");
    pid = doc.get("pid");
    quantity = doc.get("quantity");
    size = doc.get("size");
  }

  //Função que pega os dados da classe, transforma para um map a fim de armazenar os dados no banco
  Map<String, dynamic> toMap(){
    return {
      "category" : category,
      "pid" : pid,
      "quantity" : quantity,
      "size" : size,
      //"product" : pData!.toResumeMap()
    };
  }
}
