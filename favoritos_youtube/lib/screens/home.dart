import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
            centerTitle: false,
            title: Container(
            height: 35,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topLeft,//O alinhamento da imagem é feito aqui dentro do DecorationImage
                image: AssetImage("assets/logo_youtube.png")
              )
            ),
          ),
          actions: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.search, color: Colors.white, size: 30, )
            ),
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.star, color: Colors.white, size: 30, )
            )
          ],
        ),
      ),
    );
  }
}
