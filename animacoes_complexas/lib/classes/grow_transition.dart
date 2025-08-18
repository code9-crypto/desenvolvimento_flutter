import 'package:flutter/cupertino.dart';

//ESTA É A CLASSE QUE VAI FAZER TODA A ANIMAÇÃO DO WIDGET, CONTUDO PODERÁ SER REUTILIZADA PARA ANIMAR OUTROS WIDGETS
class GrowTransition extends StatelessWidget{
  late Widget child;
  late Animation<double> animation;
  
  //Essas variáveis farão a curva da animação e a opacidade
  final sizeTween = Tween<double>(begin: 100, end: 200);
  final opacityTween = Tween<double>(begin: 0.1, end: 1); 

  GrowTransition({required this.child, required this.animation});

  @override
  Widget build(BuildContext context) {
    return Center(
      //O construtor do AnimatedBuilder será o responsável de ficar escutando quando houver alteração nos atributos da animação e redesenhará apenas esta parte
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child){
          return Opacity(
            //O valor de 0 a 1 qua a variável animation está passando por parâmetro ao evaluate, será convertido no valor definido para esta variável. No caso de 0.1 a 1
            opacity: opacityTween.evaluate(animation),
            child: Container(
              //Aqui o valor da variável animation será convertido de 0 a 300
              height: sizeTween.evaluate(animation),
              width: sizeTween.evaluate(animation),
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }

}