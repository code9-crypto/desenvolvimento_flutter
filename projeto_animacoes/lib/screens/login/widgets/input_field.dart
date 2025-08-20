import 'package:flutter/material.dart';

//ESTA É A CLASSE RESPONSÁVEL POR CRIAR O CAMPO DE TEXTO
class InputField extends StatelessWidget {
  //VARIÁVEIS
  late final String hint;
  late final bool obscure;
  late final IconData icon;

  InputField({required this.hint, required this.obscure, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border( //essa parte será a borda do campo de texto
          bottom: BorderSide(
            color: Colors.white,
            width: 0.5
          )
        ),
      ),
      child: TextFormField(
        obscureText: obscure,
        style: TextStyle(
          color: Colors.white
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 15
          ),
          contentPadding: EdgeInsets.only(
            top: 30,
            right: 30,
            bottom: 30,
            left: 5
          )
        ),
      ),
    );
  }
}
