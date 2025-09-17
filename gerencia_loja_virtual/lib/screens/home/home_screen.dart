import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_loja_virtual/screens/home/blocs/user_bloc.dart';
import 'package:gerencia_loja_virtual/screens/order/tabs/orders_tab.dart';
import 'package:gerencia_loja_virtual/screens/home/tabs/users_tab.dart';
import 'package:gerencia_loja_virtual/screens/login/login_screen.dart';

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

  //CONSTANTES
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    userBloc = UserBloc(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: Text("Gerencia da loja virtual", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                auth.signOut();
                Navigator.of(context).pushReplacement(
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
        currentIndex: page, //este parâmetro está mostrando na barra em qual página está de acordo com o valor da variável page, a qual está sendo alterada no método onChangedPage
        //A troca das páginas está acontecendo neste método do onTap;
        //OBS.: mas antes de ter declarado o PageController ali em cima e depois de ter colocado esta variável no parâmetro nomeado controller no PageView
        onTap: (p){
          pgCtrl.animateToPage(
              p,
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
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            //Aqui neste onPageChanged está fazendo o controle na variável page, ou seja, quando determinado ícone for cliado, então a variável page vai receber o valor daquele item
            onPageChanged: (pg){
              setState(() {
                page = pg;
              });
            },
            controller: pgCtrl,
            children: [
              UsersTab(),
              OrdersTab(),
              Container(color: Colors.green,)
            ],
          ),
        ),
      ),
    );
  }
}
