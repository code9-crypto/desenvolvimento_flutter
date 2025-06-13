import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/home_screen.dart';

void main() async{
  //INICIALIZANDO O BANCO DE DADOS
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter's Clothing",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4, 125, 141),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 4, 125, 141),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 23.0),
          iconTheme: IconThemeData(
            color: Colors.white
          ),
        )
      ),
      home: HomeScreen(),
    );
  }
}
