import 'package:flutter/material.dart';
import 'package:projeto_animacoes/screens/home/home_screen.dart';
import 'package:projeto_animacoes/screens/login/login_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
