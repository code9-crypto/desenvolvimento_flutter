import 'dart:io';

import 'package:image_picker/image_picker.dart' as picker;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_loja_virtual/screens/product/blocs/category_bloc.dart';
import 'package:gerencia_loja_virtual/screens/product/widgets/image_source.dart';

class EditCategoryDialog extends StatelessWidget {
  
  //VARIAVEIS, BLOCS E CONTROLLERS
  final DocumentSnapshot? category;
  late final TextEditingController controller;

  //CONSTRUTORES
  EditCategoryDialog({super.key, this.category}){
    controller = TextEditingController(text: category != null ? category!.get("title") : "");
  }



  @override
  Widget build(BuildContext context) {

    final CategoryBloc catBloc = CategoryBloc(context, category); //inicializando recebidos no construtor desta classe e passando os valores ao construtor do CategoryBloc
    
    return Dialog(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min, //com este comando deixa o Dialog ocupando o mínimo possível da tela
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: (){
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => ImageSource(
                          onImageSelected: (image){
                            catBloc.setImage(image);
                          }
                      )
                  );
                },
                child: StreamBuilder(
                  stream: catBloc.outImg,
                  builder: (context, snapshot) {
                    if( snapshot.data != null ){
                      return CircleAvatar(
                        //aqui está verificando se é um arquivo ou um link da internet
                        child: snapshot.data is File ? Image.file(snapshot.data, fit: BoxFit.cover,) : Image.network(snapshot.data, fit: BoxFit.cover,),
                        backgroundColor: Colors.transparent,
                      );
                    }else{
                      return Icon(Icons.image);
                    }
                  }
                ),
              ),
              title: StreamBuilder(
                stream: catBloc.outTile,
                builder: (context, snapshot) {
                  return TextField(
                    onChanged: catBloc.setTitle, //conforme vai digitando, esta função está sendo acionada a verificada se tem valor ou não
                    controller: controller,
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error as String : null
                    ),
                  );
                }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder(
                  stream: catBloc?.outDelete,
                  builder: (context, snapshot) {
                    return TextButton(
                      onPressed: snapshot.data ? (){
                        catBloc.delete();
                      } : null,
                      child: Text(
                        "Excluir",
                        style: TextStyle(
                          color: snapshot.data ? Colors.red : Colors.transparent
                        ),
                      ),
                    );
                  }
                ),
                StreamBuilder(
                  stream: catBloc.submitValid,
                  builder: (context, snapshot) {
                    return TextButton(
                      onPressed: snapshot.hasData ? (){} : null,
                      child: Text(
                        "Salvar",
                        style: TextStyle(
                            color: snapshot.hasData ? Colors.black : Colors.grey
                        ),
                      ),
                    );
                  }
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
