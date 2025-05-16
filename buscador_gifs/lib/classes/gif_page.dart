import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class GifPage extends StatelessWidget {
  //VARIAVEIS
  late Map _gifData;

  //CONSTRUTOR
  GifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //Este iconTheme faz com que o botão padrão do tema fica da cor escolhida abaixo
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            _gifData["title"],
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          //Esta ação será um botão onde irá compartilhar o gif pelo botão
          actions: [
            IconButton(
                onPressed: (){
                  SharePlus.instance.share(
                      ShareParams(
                          text: _gifData["images"]["fixed_height"]["url"]
                      )
                  );
                },
                icon: Icon(Icons.share, color: Colors.white,)
            )
          ],
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Image.network(_gifData["images"]["fixed_height"]["url"]),
        ),
      ),
    );
  }
}
