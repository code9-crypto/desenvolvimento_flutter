import 'package:flutter/material.dart';

import '../products/product_page.dart';

class ItemMenu extends StatelessWidget {

  //VARIÁVEIS
  final IconData icon;
  final String text;

  //CONSTRUTOR
  ItemMenu(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProductPage(produto: text,))
              );
            },
          child: Column(
            children: [
              Text(text, style: TextStyle(fontSize: 25, color: Colors.grey.shade600),),
              Icon(icon, size: 120, color: Colors.cyan,)
            ],
          ),
          )
        ],
      ),
    );
  }
}
