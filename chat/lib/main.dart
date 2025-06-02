import 'package:flutter/material.dart';
import 'classes/chat.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  runApp(MyApp());
  //INICIALIZANDO O BANCO DO FIREBASE NA CLASSE PRINICIPAL
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Este theme faz referencia a todo o aplicativo: em textos, ícones, appBar ....
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.green
        )
      ),
      home: Chat(),
    );
  }
}
