import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManutCadastroPesquisa extends StatefulWidget {
  const ManutCadastroPesquisa({super.key});

  @override
  State<ManutCadastroPesquisa> createState() => _ManutCadastroPesquisaState();
}

class _ManutCadastroPesquisaState extends State<ManutCadastroPesquisa> {
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
        title: Text("Manutenção"),
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
              controller: cadNomeController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  label: Text("Nome"),
                  hintText: "Digite o nome do voluntário",
                  icon: Icon(Icons.person)),
            ),
            TextField(
              controller: cadCodController,
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
                saveData();
              },
              child: Text(
                "Cadastrar",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            Divider(),
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
                    controller: pesqController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label: Text("Nome / Código"),
                      hintText: "Nome ou código do voluntário",
                      icon: Icon(Icons.co_present_rounded),
                    ),
                  ),
                ),
                //Este é o botão que fará a pesquisa
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
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.0, top: 10.0),
              child: verifica
                  ? Text(
                      "Código: ${exibeDados["codigo"]}\nNome: ${exibeDados["nome"]}",
                      style: TextStyle(fontSize: 16),
                    )
                  : Text(""),
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
        await FirebaseFirestore.instance.collection("manutencao").get();
    data.docs.forEach((d) {
      dados.add(d.data() as Map);
    });
  }

  //esta função está fazendo a busca das informações que está na lista
  void searchData() {
    if (pesqController.text.isEmpty) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Por favor, digite o código ou nome do voluntário"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    } else {
      codNamVol = pesqController.text;
      //Aqui está fazendo a verificação tanto pelo nome ou pelo codigo do voluntario
      for (Map m in dados) {
        if (m["nome"].toString().startsWith(codNamVol.toUpperCase())) {
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

  //Esta função vai primeiro verificar se os campos estão vazios para depois prosseguir com cadastramento
  bool verificaCamposVazios() {
    if (cadNomeController.text.isEmpty && cadCodController.text.isEmpty) {
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
      return true;
    } else {
      return false;
    }
  }

  //Esta função vai primeiro checar se o voluntário está cadastrado para depois cadastrar efetivamente
  bool checkData() {
    for (int i = 0; i < dados.length; i++) {
      if (cadNomeController.text.toString().toUpperCase() ==
              dados[i]["nome"].toString().toUpperCase() ||
          cadCodController.text.toString() == dados[i]["codigo"]) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Código ou nome do voluntário já está cadastrado",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.amber,
          duration: Duration(seconds: 5),
        ));
        cadCodController.clear();
        cadNomeController.clear();
        return true;
      }
    }
    return false;
  }

  //salvando dados do voluntario no banco
  void saveData() {
    Map<String, dynamic> dados = {};
    dados["codigo"] = cadCodController.text.toUpperCase();
    dados["nome"] = cadNomeController.text.toUpperCase();
    if (!verificaCamposVazios() && !checkData()) {
      FirebaseFirestore.instance.collection("manutencao").doc().set(dados);
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
      getData();
      cadCodController.clear();
      cadNomeController.clear();
    }
  }
}
