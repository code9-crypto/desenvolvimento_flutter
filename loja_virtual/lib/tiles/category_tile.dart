import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/category_screen.dart';

//ESTA É CLASSE RESPONSÁVEL POR EXIBIR CADA ITEM NA LISTA DA TELA PRODUTOS(products_tab.dart)
class CategoryTile extends StatelessWidget {
  //***VARIÁVEIS***
  late DocumentSnapshot snapshot;

  //***CONSTRUTORES***
  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.get("icon")),
      ),
      title: Text(snapshot.get("title")),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CategoryScreen(snapshot))
        );
      },
    );
  }
}
