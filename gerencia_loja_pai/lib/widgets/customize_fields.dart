import 'package:flutter/material.dart';

//ESTA CLASSE SERÁ USADA PARA RETORNAR OS CAMPOS DE TEXTOS
class CustomizeFields extends StatelessWidget {

  //VARIAVEIS
  late String? label;
  late String? Function(String?) validator;
  late TextInputType keyBoard;
  late bool choice;
  late Widget? prefixIcon;
  late Widget? sufixIcon;

  //CONSTRUTOR
  CustomizeFields({super.key, required this.label, required this.validator, required this.keyBoard, required this.choice, this.prefixIcon, this.sufixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoard,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        suffixIcon: sufixIcon
      ),
      style: TextStyle(
        color: Colors.black
      ),
      validator: validator,
      obscureText: choice,
    );
  }
}
