import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import '../tabs/products_tab.dart';
import '../widgets/custom_drawer.dart';

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
        //Este é a primeira página(page 0)
        Scaffold(
          body: HomeTab(),
          //Para que seja possível criar um Drawer, este deverá ficar dentro de um Scaffold e é declarado desta forma
          drawer: CustomDrawer(_pageController),
        ),
        //Este é a segunda página(page 1)
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        )
      ],
    );
  }
}
