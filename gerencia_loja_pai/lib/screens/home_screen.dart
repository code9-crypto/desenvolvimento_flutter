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
                icon: ( snapshot.hasData && snapshot.data! == true ) ? Icon(Icons.exit_to_app_outlined, color: Colors.white, size: 30,) : Icon(Icons.logout_outlined, color: Colors.white, size: 30,)
              );
            }
          )
        ],
      ),
      body: Container(
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
      ),
    );
  }
}
