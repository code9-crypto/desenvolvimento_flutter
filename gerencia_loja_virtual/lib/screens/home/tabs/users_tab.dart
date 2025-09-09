import 'package:flutter/material.dart';
import 'package:gerencia_loja_virtual/screens/home/blocs/user_bloc.dart';

import '../widgets/user_tile.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = UserBloc(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: "Pesquisar",
              hintStyle: TextStyle(color: Colors.white),
              icon: Icon(Icons.search, color: Colors.white,),
              border: InputBorder.none
            ),
          ),
        ),
        //Esta ListView.separated() é usada com um separador entre os itens
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index){
                return UserTile();
              },
              separatorBuilder: (context, index){
                return Divider();
              },
              itemCount: 8
          ),
        ),
      ],
    );
  }
}
