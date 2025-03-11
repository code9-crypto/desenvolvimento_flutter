import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Centralizando o campo de texto no meio do corpo da tela
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            decoration: InputDecoration(
              //labelText: "E-mail",
              labelText: "Preço",
              icon: Icon(Icons.price_change),
              hintText: "exemplo@email.com",
              //border: InputBorder.none//OutlineInputBorder(),
              errorText: null,
              prefixText: "R\$ ",
              suffixText: "cm",
              suffixStyle: TextStyle(
                fontSize: 20
              ),
              labelStyle: TextStyle(
                fontSize: 20
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
        ),
      ),
    );
  }
}
