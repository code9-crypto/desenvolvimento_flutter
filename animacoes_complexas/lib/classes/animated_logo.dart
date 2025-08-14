import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedLogo<T> extends AnimatedWidget{
  AnimatedLogo(Animation<double> animation) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Container(
        //Essa altura e largura serão alteradas de 0 até 300 com base na variável animation
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
        //child: Icon(Icons.heart_broken, color: Colors.red, size: animation.value,), //É POSSÍVEL FAZER TAMBÉM COM ÍCONES DESTE JEITO
      ),
    );
  }
  
}