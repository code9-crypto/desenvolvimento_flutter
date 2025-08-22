import 'package:flutter/material.dart';
import 'package:projeto_animacoes/screens/home/widgets/category_view.dart';

class HomeTop extends StatelessWidget {

  final Animation<double> containerGrow;

  HomeTop({required this.containerGrow});

  @override
  Widget build(BuildContext context) {

    final screeSize = MediaQuery.of(context).size; //este código pega o tamanho total do dispositivo

    return Container(
      height: screeSize.height * 0.4, //esta altura ocupará 40% da tela do dispositivo
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover
        )
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, //espaçando no eixo vertical de forma igual
          children: [
            Text(
                "Bem-vindo, william!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.white
              ),
            ),
            Container(
              alignment: Alignment.topRight, //este alinhamento servirá para o filho deste Container
              width: containerGrow.value * 120,
              height: containerGrow.value * 120,
              decoration: BoxDecoration( //Este boxDecoration é o plano de fundo( caixa ) onde fica o filho dela
                shape: BoxShape.circle, //esteBoxShape.circle deixa a caixa com arredondamento perfeito
                image: DecorationImage(
                  image: AssetImage("assets/perfil.jpg"),
                  fit: BoxFit.cover
                )
              ),
              child: Container(
                alignment: Alignment.center,
                width: containerGrow.value * 35,
                height: containerGrow.value * 35,
                margin: EdgeInsets.only(left: 80),
                child: Text(
                  "2",
                  style: TextStyle(
                    fontSize: containerGrow.value * 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w300
                  ),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(80, 210, 194, 1.0)
                ),
              ),
            ),
            CategoryView() //esta classe é quem vai mostrar os botões e o texto da categoria
          ],
        )
      ),
    );
  }
}
