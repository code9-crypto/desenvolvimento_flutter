import 'package:flutter/material.dart';
//importando uma classe de outro pacote
//OBS.: package:nome_do_aplicativo
import 'package:todo_list/pages/todo_list_page.dart';

//Este é o método que faz executar o aplicativo
void main(){
  runApp(MyApp());
}

//Esta é a classe que mostra as telas, ícones, textos do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Esta parâmetro debugShowCheckedModeBanner é aquele que mostra uma etiqueta no lado direito superior. Setando este atributo para false, esta etiqueta some
      debugShowCheckedModeBanner: false,
      home: TodoListPage(),
    );
  }
}