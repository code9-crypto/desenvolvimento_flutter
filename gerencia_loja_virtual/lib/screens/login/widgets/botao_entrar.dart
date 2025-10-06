import 'package:flutter/material.dart';

//ESTA CLASSE ESTÁ RETORNANDO O BOTÃO ENTRAR
class BotaoEntrar extends StatelessWidget {

  //CONSTRUTOR
  const BotaoEntrar({super.key, required this.stream, required this.submit});

  //VARIÁVEIS
  final Stream stream;
  final Function submit;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream, //no parâmetro stream do construtor StreamBuilder, eu sempre passo a função ou método de saída do controlador
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.hasData ? (){
            submit();
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
