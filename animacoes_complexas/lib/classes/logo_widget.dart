import 'package:flutter/material.dart';

//ESTA É A CLASSE QUE SERÁ O FILHO PARA A CLASSE GROWTRANSITION
//OBS.: ela poderá retornar qualquer widget para ser animado
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterLogo(),
    );
  }
}