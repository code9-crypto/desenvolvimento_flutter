import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase{
  //CONTROLLERS
  final titleController = BehaviorSubject<String>();
  final imgController = BehaviorSubject();
  final deleteController = BehaviorSubject<bool>();

  //VARIAVEIS
  final DocumentSnapshot? category;
  late File image;
  late String title;

  //STREAMS
  Stream get outTile => titleController.stream.transform(
    StreamTransformer<String, String>.fromHandlers( //aqui está fazendo a verificação se o título está preenchido. Essa validação está acontecendo assim que é digitado
     handleData: (title, sink){
       if( title.isEmpty ){
         sink.addError("Insira um título");
       }else{
         sink.add(title);
       }
     }
    )
  );
  Stream get outImg => imgController.stream;
  Stream get outDelete => deleteController.stream;
  Stream get submitValid => Rx.combineLatest2(
      outTile, outImg, (a,b) => true
  );

  //CONSTRUTOR
  CategoryBloc(super.state, this.category){
    if( category != null ){
      titleController.sink.add(category!.get("title"));
      imgController.sink.add(category!.get(("icon")));
      deleteController.sink.add(true);
    }else{
      deleteController.sink.add(false);
    }
  }

  //FUNÇÕES

  //esta função irá adicionar a imagem no dialog
  void setImage(File file){
    image = file;
    imgController.sink.add(file);
  }


  void setTitle(String title){
    this.title = title;
    titleController.sink.add(title);
  }

  void delete(){
    category!.reference.delete();
  }

}