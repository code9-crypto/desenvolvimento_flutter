import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import '../tiles/drawer_tile.dart';

//ESTA CLASSE SERÁ A RESPONSÁVEL PELO DRAWER
class CustomDrawer extends StatelessWidget {
  //***VARIÁVEIS****
  late PageController controller = PageController();

  //***CONSTRUTORES****
  CustomDrawer(this.controller);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          _buildBodyBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              //Este Container será a parte superior do Drawer
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                //Este construtor Stack() permite fazer o posicionamento dos widgets de forma bem simples, conforme abaixo
                child: Stack(
                  children: [
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "FLutter's\nClothing",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      //Dentro deste ScopedModelDescendant está verificando se o usuário está logado ou não
                        //Caso esteja, então o nome dele(a) será exibido e o botão de Sair também será exibido
                        //Caso não, então será não será exibido seu nome e o botão de Entre ou cadastra-se será exibido
                      child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Olá, ${!model.isLoogedIn() ? "" : model.userData["name"]}",
                                  style: TextStyle(
                                      fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  child: Text(
                                    !model.isLoogedIn() ?
                                    "Entre ou cadastra-se >" :
                                    "Sair",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0
                                    ),
                                  ),
                                  onTap: (){
                                    if( !model.isLoogedIn() )
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => LoginScreen())
                                      );
                                    else
                                      model.signOut();
                                  },
                                )
                              ],
                            );
                          }
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              //Esses DrawerTile.loja são os construtores que criam cada um desses item na lista e que vem do arquivo drawer_tile.dart
              DrawerTile.loja(Icons.home, "Início", controller, 0),
              DrawerTile.loja(Icons.list, "Produtos", controller, 1),
              DrawerTile.loja(Icons.location_on, "Lojas", controller, 2),
              DrawerTile.loja(Icons.playlist_add_check, "Meus Pedidos", controller, 3)
            ],
          )
        ],
      ),
    );
  }

  //****FUNÇÕES****

  //retornado um degradê
  Widget _buildBodyBack() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
      );
}
