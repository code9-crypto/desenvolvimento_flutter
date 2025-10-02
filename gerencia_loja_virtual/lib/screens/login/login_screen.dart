
import 'package:flutter/material.dart';
import 'package:gerencia_loja_virtual/screens/login/blocs/login_bloc.dart';
import 'package:gerencia_loja_virtual/screens/login/widgets/botao_entrar.dart';
import 'package:gerencia_loja_virtual/screens/login/widgets/input_field.dart';

import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //INICIALIZADOR
  @override
  void initState() {
    super.initState();
    LoginBloc.outStaticState.listen((state){ //aqui eu tive que criar uma variável static para que seja possível ser acessada direto da classe
      switch(state){
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen())
          );
          break;
        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Erro"),
                content: Text("Você não possui os privilégios necessários"),
              )
          );
          break;
        case LoginState.FAIL:
        case LoginState.IDLE:
        default:
          return;
      }
    });
  }

@override
  Widget build(BuildContext context) {
  //CONSTANTES
  final loginBloc = LoginBloc(context); //instanciando a classe LoginBloc
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: StreamBuilder<LoginState>(
          initialData: LoginState.LOADING,
          stream: loginBloc.outState,
          builder: (context, snapshot) {
            switch(snapshot.data) {
              case LoginState.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                  ),
                );
              case LoginState.FAIL:
              case LoginState.SUCCESS:
              case LoginState.IDLE:
                return Stack(
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
                              stream: loginBloc.outEmail,
                              //aqui está passando a saída do email para a stream do campo email
                              onChanged: loginBloc.changeEmail,
                            ),
                            InputField(
                              input: TextInputType.text,
                              icon: Icons.lock_outline,
                              labelTxt: "Senha",
                              hint: "*******",
                              obscure: true,
                              stream: loginBloc.outPassword,
                              //aqui está passando a saída da senha para a stream do campo senha
                              onChanged: loginBloc.changePassword,
                            ),
                            SizedBox(height: 32,),
                            //CLASSE DO WIDGET DO BOTÃO ENTRAR
                            BotaoEntrar(
                              stream: loginBloc.outSubmitValid,
                              submit: loginBloc.submit,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              default:
                return Container();
            }
          }
        ),
      ),
    );
  }
}
