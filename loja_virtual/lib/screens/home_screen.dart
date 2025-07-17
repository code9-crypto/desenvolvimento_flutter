import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/widgets/cart_button.dart';
import '../tabs/orders_tab.dart';
import '../tabs/products_tab.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  //****CONTROLADORES****
  final _pageController = PageController(); //este controlador será o responsável ir para à página desejada

  @override
  Widget build(BuildContext context) {
    //Este construtor PageView permite fazer a transição entre telas de forma bem simples
    //Dentro do seu children é onde ficam todas as telas; no exemplo abaixo, cada construtor Scaffold() é uma tela diferente
    //E dentro de cada Scaffold() tem o layout e a configuração específica de cada tela
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(), //Este comando não permite fazer transição de telas arrastando o dedo
      children: [
        //Este é a primeira página(page 0 - Home)
        Scaffold(
          body: HomeTab(),
          //Para que seja possível criar um Drawer, este deverá ficar dentro de um Scaffold e é declarado desta forma
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        //Este é a segunda página(page 1 - Products)
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        //Este é a segunda página(page 2 - Lojas)
        Scaffold(
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
        ),
        //Este é a segunda página(page 3 - Pedidos)
        Scaffold(
          appBar: AppBar(
            title: Text("Meus pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
