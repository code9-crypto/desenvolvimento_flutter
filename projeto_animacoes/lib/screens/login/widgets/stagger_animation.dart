import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {

  late AnimationController controller;
  late Animation<double> buttonSqueeze;

  StaggerAnimation({required this.controller}) : //essa notação serve para inicializar a variável
      buttonSqueeze = Tween( //animando o buttonSqueeze
        begin: 320.0,
        end: 60.0
      ).animate( //aqui vem a curva da animação
        CurvedAnimation(
           parent: controller,
           curve: Interval(0.0, 0.150)
        )
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child){
          return Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: InkWell(
              onTap: (){
                controller.forward(); //aqui é onde acontece a inicialização da animação
              },
              child: Container(
                width: buttonSqueeze.value,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(30.0)
                ),
                child: buildInside(context)
              ),
            ),
          );
        }
    );
  }

  //Esta é a função que está fazendo a troca do texto para o CircularProgressIndicator
  Widget buildInside(BuildContext context){
    if( buttonSqueeze.value > 75 ){
      return Text(
        "Sign in",
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3
        ),
      );
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 1.0,
      );
    }
  }
}
