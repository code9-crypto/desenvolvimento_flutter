import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';

class ConversorMoedas extends StatefulWidget {
  const ConversorMoedas({super.key});

  @override
  State<ConversorMoedas> createState() => _ConversorMoedasState();
}

class _ConversorMoedasState extends State<ConversorMoedas> {
  String request = "https://api.hgbrasil.com/finance?key=4d7d753c";

  void requisicao() async {
    http.Response response = await http.get(Uri.parse(request));
    print(json.decode(response.body)["results"]); //é desta forma que transformamos um json em map e é assim que acessamos as chaves
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          "Conversor de Moedas",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Iniciando app..."),
            TextButton(
              onPressed: requisicao,
              child: Text("Clique aqui"),
            )
          ],
        ),
      ),
    );
  }
}
