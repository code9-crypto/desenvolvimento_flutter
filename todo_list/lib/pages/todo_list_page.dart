import 'dart:js_interop';

import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});

  //Esta é a instancia da classe controller para recuperar valores do campo de texto
  //OBS.: esta é a 1ª forma de recuperar dados do campo de texto
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Centralizando o campo de texto no meio do corpo da tela
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onSubmitted: enviando, //este parâmetro é chamado quando o botão de enviar do teclado do celular ou tecla Enter é acionada
                onChanged: mudando, // este parâmetro fica monitorando se há alguma mudança no campo; este elemento não faz nenhuma edição no campo
                //aqui dentro que é declarado o controller para aquele campo
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                //obscureText: true,
                //obscuringCharacter: "*",
                keyboardType: TextInputType.number,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),
              ),
              ElevatedButton(onPressed: login, child: Icon(Icons.login))
            ],
          ),
        ),
      ),
    );
  }

  //A função(parte lógica) deve estar dentro da classe da página
  void login() {
    String texto = emailController.text;
    print(texto);
    //emailController.clear();
    //emailController.text = "email digitado"; -> esta é a única forma de inserir um texto dentro do campo

  }

  void mudando(String texto){
    //print(texto);
  }

  void enviando(String texto){
    print(texto);
    emailController.clear();
  }


}
