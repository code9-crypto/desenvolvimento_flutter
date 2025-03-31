import 'package:calculadora_imc/classes/calculadora_imc.dart';
import 'package:flutter/material.dart';

//executando o aplicativo
void main(){
  runApp(MyApp());
}

//Classe que irá receber as telas e mandará para o runApp() executar
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculadoraImc(),
    );
  }
}

