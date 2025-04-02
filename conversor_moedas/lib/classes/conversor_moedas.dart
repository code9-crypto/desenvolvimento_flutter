import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ConversorMoedas extends StatefulWidget {
  const ConversorMoedas({super.key});

  @override
  State<ConversorMoedas> createState() => _ConversorMoedasState();
}

class _ConversorMoedasState extends State<ConversorMoedas> {
  /* VARIÁVEIS */
  String request = "https://api.hgbrasil.com/finance?key=4d7d753c";
  late double dolar;
  late double euro;

  /* CONTROLADORES */
  final realCtrl = TextEditingController();
  final dolCtrl = TextEditingController();
  final euroCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "\$ Conversor \$",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        //Como estamos trabalhando com valores que virão no futuro, então o body do Scaffold será o FutureBuilder<Map>()
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            //Aqui no switch está verificando o estado da conexão
            //Caso não tenha conexão ou esteja esperando, então será exibido na tela o texto Carregando dados...(igual no Text() abaixo)
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados...",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default: //Depois do teste acima, será retornado um valor padrão; mas antes de ser retornado, será feito uma validação
              //Caso na validação tenha erro, então será exibido na tela o texto Erro ao carregar dados(igual no Text() abaixo)
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar dados",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data!["currencies"]["USD"]["buy"];
                euro = snapshot.data!["currencies"]["EUR"]["buy"];

                //Caso não, então será exibido a tela normalmente
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        size: 150.0,
                        color: Colors.amber,
                      ),
                      buildTextField("Reais", "R\$ ", realCtrl, _realChanged), //Chamando o widget que cria o campo de texto
                      Divider( // Este divider cria uma linha para dividir os campos. Mas é possível configurar para que a linha não apareça
                        color: Colors.black,
                      ),
                      buildTextField("Dólar", "US\$ ", dolCtrl, _dolChanged),
                      Divider(
                        color: Colors.black,
                      ),
                      buildTextField("Euro", "€ ", euroCtrl, _euroChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }

  /* FUNÇÕES */
  Future<Map<String, dynamic>> getData() async {
    http.Response response = await http.get(Uri.parse(request));
    return json.decode(response.body)[
        "results"]; //é desta forma que transformamos um json em map e é assim que acessamos as chaves
  }

  void _realChanged(String text){
    if( text.isEmpty ){
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolCtrl.text = (real / dolar).toStringAsFixed(2);
    euroCtrl.text = (real / euro).toStringAsFixed(2);
  }

  void _dolChanged(String text){
    if( text.isEmpty ){
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realCtrl.text = ( dolar * this.dolar ).toStringAsFixed(2);
    euroCtrl.text = ( dolar * this.dolar / euro ).toStringAsFixed(2);
  }

  void _euroChanged(String text){
    if( text.isEmpty ){
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realCtrl.text = ( euro * this.euro ).toStringAsFixed(2);
    dolCtrl.text = ( euro * this.euro / dolar ).toStringAsFixed(2);
  }


  //Apagando todos os campos
  void _clearAll(){
    realCtrl.text = "";
    dolCtrl.text = "" ;
    euroCtrl.text = "";
  }

}

/* WIDGETS  - fica fora da classe*/

//Criando TextField de forma programática
Widget buildTextField(String label, String prefix, TextEditingController ctrl, Function(String) func){
  return TextField(
      onChanged: func,
      style: TextStyle(color: Colors.amber, fontSize: 25.0),
      controller: ctrl,
      keyboardType: TextInputType.numberWithOptions(decimal: true), //este pequeno comando permite aparecer o ponto decimal no IOS
      decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.amber),
      border: OutlineInputBorder(),
      prefixText: prefix,
      prefixStyle: TextStyle(color: Colors.amber, fontSize: 25.0),
  ));
}