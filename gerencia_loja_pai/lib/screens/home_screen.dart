import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_loja_pai/blocs/login_bloc.dart';
import 'package:gerencia_loja_pai/screens/login_screen.dart';

import '../widgets/item_menu.dart';


class HomeScreen extends StatefulWidget {
  //CONSTRUTOR
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //VARIAVEIS
  PageController pageController = PageController();
  int page = 0;

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      bottomNavigationBar: StreamBuilder(
          stream: loginBloc.outLoggedIn,
          builder: (context, snapshot){
            if( !snapshot.hasData || !snapshot.data! ){
              return Container(
                margin: EdgeInsets.symmetric(vertical: 90),
                child: iconesLoja(),
              );
            } else {
              return BottomNavigationBar(
                currentIndex: page,
                onTap: (p){
                  pageController.animateToPage(
                    p,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease
                  );
                },
                backgroundColor: Colors.cyan,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey.shade800,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Inicio"
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: "Meus Pedidos"
                  )
                ],
              );
            }
          }
      ),
      appBar: AppBar(
        title: Text("Roupas e utensílios"),
        actions: [
          StreamBuilder(
            stream: loginBloc.outLoggedIn,
            initialData: false,
            builder: (context, snapshot) {
              return IconButton(
                onPressed: ( snapshot.hasData && snapshot.data! == true ) ? (){
                  loginBloc.signOut();
                } : (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                icon: ( snapshot.hasData && snapshot.data! == true ) ? Icon(Icons.exit_to_app_outlined, color: Colors.white, size: 30,) : Icon(Icons.login_outlined, color: Colors.white, size: 30,)
              );
            }
          )
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (pg){
          setState(() {
            page = pg;
          });
        },
        controller: pageController,
        children: [
          StreamBuilder(
            stream: loginBloc.outLoggedIn,
            builder: (context, snapshot) {
              if( !snapshot.hasData || !snapshot.data! ){
                return iconesLoja();
              } else {
                return iconesLoja();
              }
            }
          ),
          Container(color: Colors.red,)
        ]
      ),
    );
  }

  //FUNÇÕES

  Widget iconesLoja(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 70),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1
        ),
        children: [
          ItemMenu(Icons.man, "Masculina"),
          ItemMenu(Icons.woman, "Feminina"),
          ItemMenu(Icons.accessibility, "Jovem"),
          ItemMenu(Icons.child_friendly, "Infantil"),
          ItemMenu(Icons.list, "Utensilios"),
        ],
      ),
    );
  }
}
