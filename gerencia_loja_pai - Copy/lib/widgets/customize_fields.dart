import 'package:flutter/material.dart';

//ESTA CLASSE SERÁ USADA PARA RETORNAR OS CAMPOS DE TEXTOS
class CustomizeFields extends StatelessWidget {

  //VARIAVEIS
  late String? label;
  late String? Function(String?)? validator;
  late TextInputType keyBoard;
  late bool choice;
  late Widget? prefixIcon;
  late Widget? sufixIcon;
  late Stream<String>? stream;
  late TextEditingController? controller;


  //CONSTRUTOR
  CustomizeFields({super.key, required this.label, this.validator, required this.keyBoard, required this.choice, this.prefixIcon, this.sufixIcon, this.stream, this.controller});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return TextFormField(
          controller: controller,
          keyboardType: keyBoard,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: prefixIcon,
            suffixIcon: sufixIcon,
            errorText: (snapshot.hasError ? snapshot.error : null) as String?
          ),
          style: TextStyle(
            color: Colors.black
          ),
          //validator: validator,
          obscureText: choice,
        );
      }
    );
  }
}
