import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("products").get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            //Esta variável dividedTiles está recebendo o construtor ListTile.divideTiles() para gerar uma linha divisória entre os itens
            var dividedTiles = ListTile.divideTiles(
                    //Este comando map que vem do snapshot, está retornando a mesma quantidade de itens que recebeu do banco de dados
                    //Mas no layout da classe CategoryTile, pois está sendo enviado(à classe CategoryTile) cada item do snapshost pelo parâmetro doc
                    //E no fim gerando uma lista com o comando .toList()
                    tiles: snapshot.data!.docs.map((doc) {
                      //Cada item está send exibido aqui
                      return CategoryTile(doc);
                    }).toList(),
                    color: Colors.grey[500]
            ).toList();
            return ListView(
              //O children está recebendo a variável dividedTiles para exibir os itens na lista
              children: dividedTiles,
            );
          }
        });
  }
}
