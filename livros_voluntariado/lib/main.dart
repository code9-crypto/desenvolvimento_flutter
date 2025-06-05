import 'package:flutter/material.dart';
import 'classes/tela_principal/home_principal.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  //INICIALIZANDO O BANCO ANTES DA APLICAÇÃO
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
      home: HomePrincipal(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 23.0),
          centerTitle: true,
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white
          )
        ),
      ),
    );
  }
}
