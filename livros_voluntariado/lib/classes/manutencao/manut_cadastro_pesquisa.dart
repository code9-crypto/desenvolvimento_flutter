import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ManutCadastroPesquisa extends StatefulWidget {
  const ManutCadastroPesquisa({super.key});

  @override
  State<ManutCadastroPesquisa> createState() => _ManutCadastroPesquisaState();
}

class _ManutCadastroPesquisaState extends State<ManutCadastroPesquisa> {

  //***VARIÁVEIS***
  List dados = [];
  String codVol = "";
  String nameVol = "";
  String verifica = "";

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
            //Este é o banco de cadastrar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Map<String, dynamic> dados = {};
                dados["nome"] = cadNomeController.text;
                dados["codigo"] = cadCodController.text;
                if (cadCodController.text.isNotEmpty && cadCodController.text.isNotEmpty) {
                  FirebaseFirestore.instance.collection("voluntarios").doc().set(dados);
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
                } else {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Um dos campos está vázio",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ));
                }
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
                    codVol = pesqController.text;
                    nameVol = pesqController.text;
                    if( codVol.isNotEmpty ){
                      for( Map m in dados ){
                        if(m["codigo"] == codVol){

                        }
                      }
                      pesqController.clear();
                    }else if( nameVol.isNotEmpty ){
                      for( Map m in dados ){
                        if(m["nome"].toString().toLowerCase() == nameVol.toLowerCase()){
                          print(m["nome"]);
                        }
                      }
                    }

                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //FUNÇÕES

  //buscando os dados no firebase e atrelando cada valor na lista
  void getData() async {
    QuerySnapshot data = await FirebaseFirestore.instance.collection("voluntarios").get();
    data.docs.forEach((d){
      dados.add(d.data());
    });
  }
}
