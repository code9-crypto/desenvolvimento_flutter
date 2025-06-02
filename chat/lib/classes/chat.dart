import 'dart:io';
import 'package:chat/classes/text_composer.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "olá",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
        //Aqui estou chamando o construtor nomeado que recebe por parâmetro uma função(que recebe por parâmetro uma string)
        //OBS.: e esta função vem com os parâmetros da classe filha(text_composer.dart)
        //E dentro da função do construtor, estou chamando outra função que irá enviar os dados(que vieram da outra classe - text-composer.dart) ao firebase
      body: TextComposer.func(sendMessage)
    );
  }

  //***FUNÇÕES***

  //ESTA FUNÇÃO ESTÁ ENVIANDO O TEXTO PARA O BANCO DE DADOS LÁ NO FIREBASE
  void sendMessage({String? text, File? imgFile}) async {

    Map<String, dynamic> data = {};

    if( imgFile != null ){
      UploadTask task = FirebaseStorage.instance.ref().child(
          DateTime.now().millisecondsSinceEpoch.toString()
      ).putFile(imgFile);

      TaskSnapshot taskSnapshot = await task; //não é necessário aplicar o onComplete
      String url = await taskSnapshot.ref.getDownloadURL(); //pegando a URL de download da imagem
      data['imgUrl'] = url;
    }

    if( text != null ){
      data['text'] = text;
    }

    FirebaseFirestore.instance.collection("messages").add(data);
  }
}
