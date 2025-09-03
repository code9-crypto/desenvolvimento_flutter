import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

import '../tiles/product_tile.dart';

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
          //Este construtor TabBar(dentro do AppBar) irá construir as tabs superior da página, normalmente sendo um ícone
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.grid_on,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(Icons.list, color: Colors.white),
              )
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("products")
                .doc(snapshot.id)
                .collection("itens")
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                //Este construtor TabBarView(no body do Scaffold) será à página em si
                return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    //Aqui nesta children é onde está a divisão das tabs, a gridView é a primeira tab, e listView é a segunda tab
                    children: [
                      GridView.builder(
                          padding: EdgeInsets.all(4.0),
                          //O parâmetro nomeado - gridDelegate - é o responsável por mostrar a quantidade de itens na horizontal
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //Aqui é a quantidade de itens na horizontal
                              crossAxisCount: 2,
                              //Este é o espaçamento entre os itens na vertical
                              mainAxisSpacing: 4,
                              //Este é o espaçamento entre os itens na horizontal
                              crossAxisSpacing: 4,
                              childAspectRatio: 0.65),
                          itemCount: snapshot.data!.docs.length,
                          //Aqui está construindo item por item(um a um) de acordo com index que está sendo passado por parâmetro
                          itemBuilder: (context, index) {
                            ProductData pData = ProductData.fromData(
                                snapshot.data!.docs[index]);
                            pData.category = this
                                .snapshot
                                .id
                                .toString(); //este snapshot faz parte do FutureBuilder, pois este tem o ID da categoria por isso foi usado o this.snapshot
                            return ProductTile("grid",
                                pData); //aqui está fazendo um apontamento para mostrar como vai ficar o layout da cada item
                          }),
                      ListView.builder(
                          padding: EdgeInsets.all(4.0),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductData pData = ProductData.fromData(
                                snapshot.data!.docs[index]);
                            pData.category = this.snapshot.id;
                            return ProductTile("list",
                                pData); //aqui está fazendo um apontamento para mostrar como vai ficar o layout da cada item
                          })
                    ]);
              }
            }),
      ),
    );
  }
}
