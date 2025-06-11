import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  //****CONTROLADORES****
  final _pageController = PageController(); //este controlador será o responsável ir para à página desejada

  @override
  Widget build(BuildContext context) {
    //Este construtor PageView permite fazer a transição entre telas de forma bem simples
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(), //Este comando não permite fazer transição de telas arrastando o dedo
      children: [
        HomeTab()
      ],
    );
  }
}
