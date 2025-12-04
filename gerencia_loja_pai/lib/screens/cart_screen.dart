import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:gerencia_loja_pai/main.dart";

class CartScreen extends StatelessWidget {

  //VARIAVEIS
  late String userID;

  //CONSTRUTOR
  CartScreen(this.userID);

  //CONSTANTES
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: firestore.collection("users").doc(userID).collection("carrinho").get(),
          builder: (context, snapshot){
            if( !snapshot.hasData ){
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if( snapshot.data!.size <= 0  ) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart,
                      size: 150,
                      color: Colors.cyan,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Não há item no carrinho",
                      style: TextStyle(
                        fontSize: 23.0,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return 
            }
          }
        ),
      ),
    );
  }
  //FUNÇÕES

  //Esta função pega o link do google drive e transforma para um link válido de modo que a imagem possa ser exibida na listview
  String corrigirLinkGoogleDrive(String urlOriginal) {
    final regex = RegExp(r'/d/([a-zA-Z0-9_-]+)');
    final match = regex.firstMatch(urlOriginal);
    if (match != null) {
      final id = match.group(1);
      return 'https://drive.google.com/uc?export=view&id=$id';
    }
    return urlOriginal; // se não bater o padrão, devolve o original
  }
}
