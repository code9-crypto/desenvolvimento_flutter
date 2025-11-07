import 'package:flutter/material.dart';
import '../widgets/login_fields.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.tela});
  final Widget tela;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Autenticar na Loja"),
      ),
      body: LoginFields(tela: tela,),
    );
  }
}
