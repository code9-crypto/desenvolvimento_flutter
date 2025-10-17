import 'package:flutter/material.dart';
import 'package:loja_virutal_pai/widgets/login_fields.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Autenticar na Loja"),
      ),
      body: LoginFields(),
    );
  }
}
