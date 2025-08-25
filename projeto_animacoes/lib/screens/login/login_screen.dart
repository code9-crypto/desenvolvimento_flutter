import 'package:flutter/material.dart';
import 'package:projeto_animacoes/screens/login/widgets/form_container.dart';
import 'package:projeto_animacoes/screens/login/widgets/signup_button.dart';
import 'package:projeto_animacoes/screens/login/widgets/stagger_animation.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import '../home/home_screen.dart';

//ESTA É A TELA/CLASSE QUE FARÁ TODA A ANIMAÇÃO
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animaCtrl;

  @override
  void initState() {
    super.initState();

    animaCtrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    //Criando um status listener para quando a animação terminar, redirecionar para outra tela
    animaCtrl.addStatusListener((status){
      if( status == AnimationStatus.completed ){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen())
        );
      }
    });
  }

  //Esse dispose é para liberar a memória, ou seja, limpeza para não sobrecarregar
  @override
  void dispose() {
    animaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1; //este timeDilation deixa as animãções do app mais devagar(conforme o número for aumentando)

    return Scaffold(
      body: Container(
        //Aqui é parte da imagem de fundo
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/background.jpg",
                ),
                fit: BoxFit.cover)),
        child: ListView(children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 70, bottom: 32),
                    child: Image.asset(
                      "assets/tickicon.png",
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ), //Este parâmetro coloca a imagem na tela
                  ),
                  FormContainer(), //esta classe está sendo chamada, pois ela será a responsável em criar os campos do formulário
                  SignupButton() //esta classe está sendo chamada para criar o botão de cadastra-se
                ],
              ),
              //Para que funcione a parte do botão de animar e cobrir toda a tela, devemos usar o Stack
              //Esta classe está sendo chamada para animar o botão quando clicado e depois cobrir toda a tela para entrar na outra tela
              StaggerAnimation(controller: animaCtrl)
            ],
          ),
        ]),
      ),
    );
  }
}
