import 'package:agenda_de_contatos/classes/contact_helper.dart';
import 'package:flutter/material.dart';

class AgendaContatos extends StatefulWidget {
  const AgendaContatos({super.key});

  @override
  State<AgendaContatos> createState() => _AgendaContatosState();
}

class _AgendaContatosState extends State<AgendaContatos> {

  //*** VARIAVEIS ****
  Map dados = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(onPressed: teste, child: Icon(Icons.add))
                  )
                ]
              )
            ],
          ),
        )
    );
  }

  //****FUNÇÕES****
  void teste(){
    dados["idColumn"] = 0;
    dados["nameColumn"] = "William";
    dados["phoneColumn"] = "13988474371";
    dados["emailColumn"] = "convidadoc38@gmail.com";
    dados["imgColumn"] = "/imagens/123456.png";
    print(Contact.fromMap(dados));
  }
}
