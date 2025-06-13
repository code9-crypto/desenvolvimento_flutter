import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//ESTE É A CLASSE RESPONSÁVEL POR EXIBIR OS ITENS DE CADA CATEGORIA(exibí-los tanto na forma de lista como na forma de grade)
class CategoryScreen extends StatelessWidget {
  //***VARIÁVEIS****
  late DocumentSnapshot snapshot;

  //***CONSTRUTORES****
  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.get("title")),
          centerTitle: true,
          bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.grid_on, color: Colors.white,),),
                Tab(icon: Icon(Icons.list, color: Colors.white),)
              ],
              indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(color: Colors.green,),
              Container(color: Colors.red,)
            ]
        ),
      ),
    );
  }
}
