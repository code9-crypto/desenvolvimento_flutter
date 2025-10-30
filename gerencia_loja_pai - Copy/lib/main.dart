import 'package:flutter/material.dart';
import 'package:gerencia_loja_pai/screens/home_screen.dart';

void main(){
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        //Aqui é a configuração padrão da appBar para todas as telas
          appBarTheme: AppBarTheme(
            centerTitle: true,
            foregroundColor: Colors.white,
            backgroundColor: Colors.cyan,
          )
      ),
    );
  }
}