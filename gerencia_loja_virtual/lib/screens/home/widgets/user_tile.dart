import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key});

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyle(color: Colors.white);

    return ListTile(
      title: Text(
        "title",
        style: textStyle
      ),
      subtitle: Text(
        "subtitle",
        style:  textStyle,
      ),
      //Este parâmetro trailing permite deixar os itens no lado direito da ListTile
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end, //alinhando tudo de forma uniforme para direita
        children: [
          Text(
            "Pedidos: 0",
            style: textStyle,
          ),
          Text(
            "Gasto: 0",
            style: textStyle,
          )
        ],
      ),
    );
  }
}
