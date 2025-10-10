import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_loja_virtual/screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      builder: (BuildContext context, Widget? child){
        return SafeArea(
          top: false,
          child: child ?? const SizedBox.shrink()
        );
      },
    );
  }
}
