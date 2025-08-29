import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerencia_loja_virtual/screens/login/blocs/login_bloc.dart';
import 'package:gerencia_loja_virtual/screens/login/widgets/botao_entrar.dart';
import 'package:gerencia_loja_virtual/screens/login/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
@override
  Widget build(BuildContext context) {

    final loginBloc = LoginBloc(context); //instanciando a classe LoginBloc

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
                    InputField( //classe do widget do campo de texto
                      input: TextInputType.emailAddress,
                      icon: Icons.person_outline,
                      labelTxt: "Usuário",
                      hint: "fulano@email.com",
                      obscure: false,
                      stream: loginBloc.outEmail, //aqui está passando a saída do email para a stream do campo email
                      onChanged: loginBloc.changeEmail,
                    ),
                    InputField(
                      input: TextInputType.text,
                      icon: Icons.lock_outline,
                      labelTxt: "Senha",
                      hint: "*******",
                      obscure: true,
                      stream: loginBloc.outPassword,//aqui está passando a saída da senha para a stream do campo senha
                      onChanged: loginBloc.changePassword,
                    ),
                    SizedBox(height: 32,),
                    BotaoEntrar(
                      stream: loginBloc.outSubmitValid, //classe do widget do botão entrar
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
