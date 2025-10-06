import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gerencia_loja_virtual/screens/home/blocs/user_bloc.dart';
import 'package:gerencia_loja_virtual/screens/order/blocs/orders_bloc.dart';
import 'package:gerencia_loja_virtual/screens/order/tabs/orders_tab.dart';
import 'package:gerencia_loja_virtual/screens/home/tabs/users_tab.dart';
import 'package:gerencia_loja_virtual/screens/login/login_screen.dart';
import 'package:gerencia_loja_virtual/screens/product/products_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //VARIAVEIS
  late PageController pgCtrl = PageController(); //este será usado para fazer o controle da transição de páginas no PageView
  int page = 0;
  late UserBloc userBloc;
  late OrdersBloc ordersBloc;

  //CONSTANTES
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    userBloc = UserBloc(context);
    ordersBloc = OrdersBloc(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: Text("Gerencia da loja virtual", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                auth.signOut();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginScreen())
                );
              },
              icon: Icon(Icons.exit_to_app, color: Colors.white,)
          )
        ],
      ),
      backgroundColor: Colors.grey.shade800,
      //OBS.: o bottomNavigationBar será mantido em todas as telas
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page, //este parâmetro está mostrando na barra em qual página está de acordo com o valor da variável page, a qual está sendo alterada no método onPageChange(a qual está ali embaixo)
        //A troca das páginas está acontecendo neste método do onTap;
        //OBS.: mas antes de ter declarado o PageController ali em cima e depois de ter colocado esta variável no parâmetro nomeado controller no PageView
        onTap: (page){
          pgCtrl.animateToPage(
              page,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease
          );
        },
        backgroundColor: Colors.pinkAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade800,
        items: [
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           label: "Clientes",
         ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Pedidos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Produtos",
          )
        ]
      ),
      body: SafeArea(
        child: BlocProvider( //este BlocProvider irá permitir que o UserBloc seja acessível para as de mais telas do app
          create: (_) => UserBloc(context),
          child: BlocProvider(
            create: (_) => OrdersBloc(context), //este BlocProvider(tipo OrdersBloc) está abaixo do UserBloc a fim de este ter acesso ao dados do usuário
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              //Aqui neste onPageChanged está fazendo o controle na variável page, ou seja, quando determinado ícone(da barra inferior) for clicado, então a variável page vai receber o valor daquele item
              //O qual o valor daquele item está sendo passado por parâmetro nesta função e a variável page está recebendo valor
              onPageChanged: (pg){
                setState(() {
                  page = pg;
                });
              },
              controller: pgCtrl,
              children: [
                UsersTab(),
                OrdersTab(),
                ProductsTab(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: buildFloating(), //Este floating action button será exibido de forma diferente de acordo com a tela que for exibida
    );
  }

  //Esta é a função que mostra qual será o botão do floatingActionButton que será apresentado de acordo com a tela exibida
  Widget buildFloating(){
    switch(page){
      case 0:
        return Container();
        break;
      case 1:
        return SpeedDial( //Este SpeedDial() é o floatingActionButton que quando clicado pode mostrar outros botões de forma mais animada
          backgroundColor: Colors.pinkAccent,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild( //Esses SpeedDialChild() são os botões que apareceram quando clicado o floatingActionButton
              child: Icon(Icons.arrow_downward, color: Colors.pinkAccent,),
              backgroundColor: Colors.white,
              label: "Concluídos abaixo",
              labelStyle: TextStyle(fontSize: 14),
              onTap: (){
                ordersBloc.setOrderCriteria(SortCriteria.READY_LAST);
              }
            ),
            SpeedDialChild( //Esses SpeedDialChild() são os botões que apareceram quando clicado o floatingActionButton
                child: Icon(Icons.arrow_upward, color: Colors.pinkAccent,),
                backgroundColor: Colors.white,
                label: "Concluídos acima",
                labelStyle: TextStyle(fontSize: 14),
                onTap: (){
                  ordersBloc.setOrderCriteria(SortCriteria.READY_FIRST);
                }
            )
          ], //Este SpeedDial() é o floatingActionButton que quando clicado pode mostrar outros botões de forma mais animada
          child: Icon(Icons.sort, color: Colors.white,),
        );
        break;
      default:
        return Container();
    }
  }
}
