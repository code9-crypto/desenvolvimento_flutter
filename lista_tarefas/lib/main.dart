import 'package:flutter/material.dart';
import 'package:lista_tarefas/classes/lista_tarefas.dart';

//Função que vai rodar o aplicativo
void main(){
  runApp(MyApp());
}

//Esta é classe que retorna o widget das telas do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListaTarefas(),
    );
  }
}
