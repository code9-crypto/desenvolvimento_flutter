import 'package:comandos_linux/screens/comands_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  //INICIALIZANDO O BANCO
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ComandsScreen(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white
            ),
            backgroundColor: Colors.black,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
            centerTitle: true),
      ),
    );
  }
}
