import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

//ESTA É A CLASSE QUE EXIBE O LAYOUT DO CARRINHO
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu carrinho"),
        centerTitle: true,
        //Essas actions[] por padrão é localizada na parte direita da appBar
        actions: [
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model){
                  int p = model.products.length;
                  return Text(
                    "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
