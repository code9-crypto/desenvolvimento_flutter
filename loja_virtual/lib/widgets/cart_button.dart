import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/cart_screen.dart';

//ESTA CLASSE SERÁ O ÍCONE DO CARRINHO
class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28)
      ),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CartScreen())
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
