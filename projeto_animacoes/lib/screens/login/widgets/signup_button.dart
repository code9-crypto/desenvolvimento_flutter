import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 160
      ),
      child: TextButton(
        onPressed: (){},
        child: Text(
          "Não possui uma conta? Cadastre-se!",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis, //este parâmetro faz com que o texto fique com 3 pontos(reticências) caso o texto passe do tamanho normal
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.white,
            fontSize: 12,
            letterSpacing: 0.5 //este parâmetro deixa o espaçamento entre as letras no texto
          ),
        )
      ),
    );
  }
}
