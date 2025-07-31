import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        //Colocando uma imagem na barra de título da appBar
        title: Container(
          height: 35,
          child: Image.asset("assets/logo_youtube.png"),
        ),
        elevation: 0, //este parâmetro quando setado para 0, não deixa uma sombra que fica abaixo da appBar
        //Botões da AppBar(por padrão fica alinhada do lado direito)
        actions: [
          Align(
            alignment: Alignment.center,
            child: Text("0", style: TextStyle(color: Colors.white),),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.star, color: Colors.white, size: 30, )
          ),
          IconButton(
              onPressed: () async{
                //este é o comando que mostrará a tela de pesquisa apontando para a classe DataSearch
                String? result = await showSearch(context: context, delegate: DataSearch());
                print(result);
              },
              icon: Icon(Icons.search, color: Colors.white, size: 30, )
          )
        ],
      ),
      body: Container(),
    );
  }
}
