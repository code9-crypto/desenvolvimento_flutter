import 'package:flutter/material.dart';
//importando uma classe de outro pacote
//OBS.: package:nome_do_aplicativo
import 'package:todo_list/pages/todo_list_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListPage(),
    );
  }
}