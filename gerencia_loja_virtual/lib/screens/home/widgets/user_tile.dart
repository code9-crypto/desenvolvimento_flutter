import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserTile extends StatelessWidget {

  final Map<String, dynamic> user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyle(color: Colors.white);

    if( user.containsKey("money") ) {
      return ListTile(
        title: Text(
            user["name"],
            style: textStyle
        ),
        subtitle: Text(
          user["email"],
          style: textStyle,
        ),
        //Este parâmetro trailing permite deixar os itens no lado direito da ListTile
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          //alinhando tudo de forma uniforme para direita
          children: [
            Text(
              "Pedidos: ${user["orders"]}",
              style: textStyle,
            ),
            Text(
              "Gasto: R\$${user["money"].toStringAsFixed(2)}",
              style: textStyle,
            )
          ],
        ),
      );
    }else{
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 50,
              height: 20,
              child: Shimmer.fromColors( //Este Shimmer.fromColors dá um efeito de carregamento, o que é um detalhe muito bom para UserExperience
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Container(
                  color: Colors.white.withAlpha(50),
                  margin: EdgeInsets.symmetric(vertical: 4),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 20,
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Container(
                  color: Colors.white.withAlpha(50),
                  margin: EdgeInsets.symmetric(vertical: 4),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
