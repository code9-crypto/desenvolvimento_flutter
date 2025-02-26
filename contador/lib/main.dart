import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  //runApp() -> é a função que roda o app
  runApp(const MyApp());
}

//Configurações do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //MaterialApp() -> é o parâmetro que da função runApp(), que diz qual será a tela home
    return const MaterialApp(
      //Instancia a classe da home page
      home: HomePage(),
    );
  }
}

//Tela da Home
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //home: Container() -> é o parâmetro de MaterialApp(); A tela home que será apresentada
      //color: Colors.yellow -> é o parâmetro de Container(); A cor que será apresentada
      color: Colors.black,
      //Colocando texto dentro da tela, como filho da tela
      child: const Text("Olá mundo!!!!"),
      //Alinhando o texto
      alignment: Alignment.center,
    );
  }
}

