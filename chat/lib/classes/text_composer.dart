//IMPORTANTE: AS VARIÁVEIS DO TIPO FUNÇÃO DEVEM SER DECLARADAS DENTRO DA CLASSE STATEFULWIDGET
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class TextComposer extends StatefulWidget {
  //Este é o construtor padrão
  TextComposer({super.key});

  //Este construtor nomeado será usado para receber uma função de outra classe
  TextComposer.func(this.sendMessage);

  //Esta é uma variável do tipo função que recebe uma string e um file como parâmetros
  //E esses dados são enviados à classe Pai(chat.dart)
  Function({String? text, File? imgFile})? sendMessage;


  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  //***VARIAVEIS***
  bool _isComposing = false; //esta variavel será usada para fazer com que o campo seja habilitado(se tiver texto no campo) ou desabilitado(se não tiver texto no campo)

  //***CONTROLADORES***
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              //Este construtor IconButton, permite colocar uma função dentro de um ícone, fazendo com que seja um botão
              IconButton(
                  onPressed: () async {
                    //tirando uma foto da camera do celular e armazenando numa variavel para depois chamar a função que envia ao firebase
                    final File? imgFile =  await ImagePicker().pickImage(source: ImageSource.camera) as File;
                    if( imgFile == null ) return;
                    widget.sendMessage!(imgFile: imgFile);
                  },
                  icon: Icon(Icons.camera_alt_rounded, color: Colors.blue,)
              ),
              Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
                    //neste onChanged, caso tenha algum valor no campo, então a variavel receberá 'true' se não receberá 'false'
                    onChanged: (text){
                      setState(() {
                        _isComposing = text.isNotEmpty; //este comando retorna true ou false
                      });
                    },
                    onSubmitted: (text){
                      //Para chamar a função que vai como parâmetro no construtor da classe é deste jeito
                      widget.sendMessage!(text: text);
                      _reset();
                    },
                  )
              ),
              IconButton(
                  //Neste onPressed, se a variável _isComposing for true, então o botão será habilitado para executar alguma função, se for false então o botão será desabilitado
                  onPressed: _isComposing ? (){
                    //Para chamar a função que vai como parâmetro no construtor da classe é deste jeito
                    widget.sendMessage!(text: _controller.text);
                    _reset();
                  } : null,
                  icon: Icon(Icons.send,)
              )
            ],
          ),
        ),
      ],
    );
  }

  //***FUNÇÕES***

  //ESTA FUNÇÃO FARÁ COM QUE O CAMPO DE TEXTO SEJA APAGADO E O BOTÃO DESABILITADO
  void _reset(){
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }
}
