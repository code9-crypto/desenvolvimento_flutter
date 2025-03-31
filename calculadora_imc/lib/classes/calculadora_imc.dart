import 'package:flutter/material.dart';

class CalculadoraImc extends StatefulWidget {
  CalculadoraImc({super.key});

  @override
  State<CalculadoraImc> createState() => _CalculadoraImcState();
}

class _CalculadoraImcState extends State<CalculadoraImc> {

  //Controladores dos campos
  final TextEditingController pesoCtrl = TextEditingController();
  final TextEditingController alturaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Esta appBar é a barra que fica na parte de cima do aplicativo
      appBar: AppBar(
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        //Este parâmetro faz com que o título fique centralizado
        backgroundColor: Colors.green,
        //Essas actions será, normalmente, os botões
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                pesoCtrl.clear();
                alturaCtrl.clear();
              });
            },
            icon: Icon(Icons.refresh),
            color: Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView( //Este construtor é do ScrollView, usado para evitar o erro de quando o teclado sobresair as informações do aplicativo
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //Este comando faz com que a linha estique ao máximo da coluna
          //Dentro das listas, sempre será escrito direto os construtores das classes
          children: [
            Icon(
              Icons.person_outline,
              size: 120,
              color: Colors.green,
            ),
            TextField(
              controller: pesoCtrl,
              keyboardType: TextInputType.number,
              //Este é o comando que define qual o tipo de teclado que será exibido ao usuário
              decoration: InputDecoration(
                  labelText: "Peso em (kg)",
                  labelStyle: TextStyle(color: Colors.green)),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25.0, color: Colors.green),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: alturaCtrl,
              keyboardType: TextInputType.number,
              //Este é o comando que define qual o tipo de teclado que será exibido ao usuário
              decoration: InputDecoration(
                  labelText: "Altura em (cm)",
                  //label: Text("teste"), Este parâmetro tem o mesmo efeito que o labelText
                  labelStyle: TextStyle(color: Colors.green)),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25.0, color: Colors.green),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Calcular",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(50, 50),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(height: 20,),
            Text( // Este construtor é para colocar texto direto na tela
              "Info",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
            ),
          ],
        ),
      ),
    );
  }
}
