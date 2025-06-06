import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BrigCadastroPesquisa extends StatefulWidget {
  const BrigCadastroPesquisa({super.key});

  @override
  State<BrigCadastroPesquisa> createState() => _BrigCadastroPesquisaState();
}

class _BrigCadastroPesquisaState extends State<BrigCadastroPesquisa> {

  //***VARIÁVEIS***
  List dados = [];
  String codNamVol = "";
  bool verifica = false;
  Map<String, dynamic> exibeDados = {};

  //***CONTROLADORES***
  TextEditingController cadNomeController = TextEditingController();
  TextEditingController cadCodController = TextEditingController();
  TextEditingController pesqController = TextEditingController();

  //INICIALIZANDO O APP COM OS DADOS DO BANCO CARREGADOS E ATRALELADOS A UMA VARIÁVEL DO TIPO LISTA
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brigada"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "CADASTRAR VOLUNTÁRIO",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  label: Text("Nome"),
                  hintText: "Digite o nome do voluntário",
                  icon: Icon(Icons.person)),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  label: Text("Código"),
                  hintText: "Digite o código do voluntário",
                  icon: Icon(Icons.numbers_outlined)),
            ),
            SizedBox(height: 10),
            //Este é o botão de cadastrar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                checkData();
              },
              child: Text(
                "Cadastrar",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            Text(
              "-" * 50,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 10),
            Text(
              "PESQUISAR VOLUNTÁRIO",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label: Text("Nome / Código"),
                      hintText: "Nome ou código do voluntário",
                      icon: Icon(Icons.co_present_rounded),
                    ),
                  ),
                ),
                //Este é o botão de pesquisar
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    searchData();
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 40.0, top: 10.0),
                child: verifica ?
                Text(
                  "Código: ${exibeDados["codigo"]}\nNome: ${exibeDados["nome"]}",
                  style: TextStyle(fontSize: 16),) :
                Text("")
            )
          ],
        ),
      ),
    );
  }

  //FUNÇÕES

  //buscando os dados no firebase e atrelando cada valor na lista
  void getData() async {
    QuerySnapshot data =
    await FirebaseFirestore.instance.collection("brigada").get();
    data.docs.forEach((d) {
      dados.add(d.data());
    });
  }

  //esta função está fazendo a busca das informações que está na lista
  void searchData() {
    if (pesqController.text.isEmpty) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Por favor, digite o código ou nome do voluntário"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          )
      );
    } else {
      codNamVol = pesqController.text;
      //Aqui está fazendo a verificação tanto pelo nome ou pelo codigo do voluntario
      for (Map m in dados) {
        if (m["nome"].toString().startsWith(
            codNamVol.toUpperCase())) {
          setState(() {
            exibeDados["codigo"] = m["codigo"];
            exibeDados["nome"] = m["nome"];
            verifica = true;
          });
          pesqController.clear();
        } else if (m["codigo"] == codNamVol) {
          setState(() {
            exibeDados["codigo"] = m["codigo"];
            exibeDados["nome"] = m["nome"];
            verifica = true;
          });
          pesqController.clear();
        } else {
          exibeDados["info"] = false;
        }
      }
    }
  }

  //salvando dados do voluntario no banco
  void saveData() {
    Map<String, dynamic> dados = {};
    dados["codigo"] = cadCodController.text.toUpperCase();
    dados["nome"] = cadNomeController.text.toUpperCase();
    if (cadCodController.text.isNotEmpty && cadCodController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("brigada").doc().set(dados);
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Voluntário cadastrado com sucesso!!!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
      cadCodController.clear();
      cadNomeController.clear();
    }
  }

  //Esta função vai primeiro checar se o voluntário está cadastrado para depois cadastrar efetivamente
  void checkData() {
    if (cadNomeController.text.isEmpty || cadCodController.text.isEmpty) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Um dos campos está vázio",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }

    if (cadNomeController.text.isNotEmpty || cadCodController.text.isNotEmpty) {
      for (int i = 0; i < dados.length; i++) {
        if (cadNomeController.text.toString().toUpperCase() ==
            dados[i]["nome"].toString().toUpperCase() ||
            cadCodController.text.toString() == dados[i]["codigo"]) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Código ou nome do voluntário já está cadastrado",
                  style: TextStyle(color: Colors.black),),
                backgroundColor: Colors.amber,
                duration: Duration(seconds: 3),
              )
          );
        }
      }
      cadCodController.clear();
      cadNomeController.clear();
    } else {
      saveData();
      getData();
    }
  }
}
