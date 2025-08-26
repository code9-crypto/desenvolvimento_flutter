import 'package:flutter/material.dart';
import 'package:gerencia_loja_virtual/screens/login/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {


  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //VARIÁVEIS
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String msg = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.store,
                      color: Colors.pinkAccent,
                      size: 160,
                    ),
                    InputField(
                      input: TextInputType.emailAddress,
                      icon: Icons.person_outline,
                      labelTxt: "Usuário",
                      hint: "fulano@email.com",
                      obscure: false
                    ),
                    InputField(
                      input: TextInputType.text,
                      icon: Icons.lock_outline,
                      labelTxt: "Senha",
                      hint: "*******",
                      obscure: true
                    ),
                    SizedBox(height: 32,),
                    ElevatedButton(
                      onPressed: (){},
                      child: Text("Entrar"),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(0, 70),
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
