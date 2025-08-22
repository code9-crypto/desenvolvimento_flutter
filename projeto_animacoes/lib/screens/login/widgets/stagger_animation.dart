import 'package:flutter/material.dart';

//ESTA CLASSE É A RESPONSÁVEL DE TODA A CONFIGURAÇÃO DA ANIMAÇÃO
//IMPORTANTE: A ANIMAÇÃO NÃO ESTÁ ACONTECENDO AQUI, ELA ACONTECERÁ NA TELA/CLASSE QUE IMPORTAR ESTA CLASSE AQUI
class StaggerAnimation extends StatelessWidget {

  late AnimationController controller;
  late Animation<double> buttonSqueeze;
  late Animation<double> buttonZoomOut;

  StaggerAnimation({required this.controller}) : //essa notação serve para inicializar a variável
      buttonSqueeze = Tween( //animando o buttonSqueeze
        begin: 320.0,
        end: 60.0
      ).animate( //aqui vem a curva da animação
        CurvedAnimation(
           parent: controller,
           curve: Interval(0.0, 0.150)
        )
      ),

      buttonZoomOut = Tween(
        begin: 60.0,
        end: 1000.0,
      ).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 1)
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
              child:
              buttonZoomOut.value <= 60 ?
              Container(
                width: buttonSqueeze.value,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(30.0)
                ),
                child: buildInside(context)
              ) :
              Container(
                  width: buttonZoomOut.value,
                  height: buttonZoomOut.value,
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      shape: buttonZoomOut.value < 500 ? BoxShape.circle : BoxShape.rectangle
                  ),
              )
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
