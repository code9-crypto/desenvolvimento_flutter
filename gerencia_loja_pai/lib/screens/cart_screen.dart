import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:gerencia_loja_pai/main.dart";

class CartScreen extends StatelessWidget {

  //VARIAVEIS
  late String userID;

  CartScreen(this.userID);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(userID)
          ],
        ),
      ),
    );
  }
}
