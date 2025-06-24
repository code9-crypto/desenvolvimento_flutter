import 'package:cloud_firestore/cloud_firestore.dart';

//ESTA CLASSE VAI TRABALHAR EM CIMA APENAS DOS CAMPOS DOS DOCUMENTOS DO BANCO
class ComandsData{

  late String titulo;
  late String id;

  ComandsData(DocumentSnapshot snapshot){
    titulo = snapshot.get("title");
    id = snapshot.id;
  }

}