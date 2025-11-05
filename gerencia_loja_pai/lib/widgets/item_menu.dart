import 'package:flutter/material.dart';

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
          Text(text, style: TextStyle(fontSize: 25, color: Colors.grey.shade600),),
          IconButton(
            onPressed: (){
              print("Cliquei no ícone $text");
            },
            icon: Icon(icon, size: 120, color: Colors.cyan,),
          )
        ],
      ),
    );
  }
}
