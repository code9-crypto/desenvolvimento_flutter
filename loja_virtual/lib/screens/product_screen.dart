import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductScreen extends StatefulWidget {
  //***VARIAVEIS***
  ProductData product;

  //***CONSTRUTOR***
  ProductScreen(this.product);

  @override
  //Para enviar o parâmetro do construtor ao State é dessa forma
  State<ProductScreen> createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  //***VARIAVEIS DO STATE***
  late ProductData product;

  //***CONSTRUTOR DO STATE
  _ProductScreenState(this.product);

  //OBS.: recebendo o parâmetro deste jeito, vai evitar de ficar chamando o widget para ficar chamando a variável da classe

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(product.title),
        centerTitle: true,
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
