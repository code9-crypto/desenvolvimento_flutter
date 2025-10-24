import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  //VARIAVEIS
  late String produto;

  //CONSTRUTOR
  ProductPage({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(produto == "Utensílios" ? "$produto" : "Moda $produto"),
      ),
    );
  }
}
