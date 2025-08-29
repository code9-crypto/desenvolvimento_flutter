import 'package:flutter/material.dart';

//ESTA CLASSE ESTÁ RETORNANDO O BOTÃO ENTRAR
class BotaoEntrar extends StatelessWidget {

  //CONSTRUTOR
  BotaoEntrar({super.key, required this.stream});

  //VARIÁVEIS
  final Stream<bool> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: stream, //no parâmetro stream do construtor StreamBuilder, eu sempre paço a função ou método de saída do controlador
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.hasData ?  (){
            print("Cliquei aqui no botão");
          } : null,
          style: ElevatedButton.styleFrom(
            fixedSize: Size(0, 70),
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.pinkAccent.withAlpha(140),
            disabledForegroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Text("Entrar"),
        );
      }
    );
  }
}
