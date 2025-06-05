import 'package:flutter/material.dart';

class BrigCadastroPesquisa extends StatefulWidget {
  const BrigCadastroPesquisa({super.key});

  @override
  State<BrigCadastroPesquisa> createState() => _BrigCadastroPesquisaState();
}

class _BrigCadastroPesquisaState extends State<BrigCadastroPesquisa> {
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
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
}
