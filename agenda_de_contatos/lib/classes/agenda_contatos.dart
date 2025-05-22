import 'dart:io';

import 'package:agenda_de_contatos/classes/contact_helper.dart';
import 'package:flutter/material.dart';

class AgendaContatos extends StatefulWidget {
  const AgendaContatos({super.key});

  @override
  State<AgendaContatos> createState() => _AgendaContatosState();
}

class _AgendaContatosState extends State<AgendaContatos> {
  //*** VARIAVEIS ****
  ContactHelper helper = ContactHelper();
  List<Contact> contacts = [];

  //INICIANDO O APLICATIVO PEGANDO OS DADOS DO BANCO E PASSANDO PARA A LISTA DE CONTATOS
  @override
  void initState() {
    super.initState();
    helper.getAllContacts().then((data) {
      setState(() {
        contacts = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Contatos",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          //ESTE CONSTRUTOR É O BOTÃO QUE FICA NO CANTO DIREITO INFERIOR DO APP
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return contactCard(context, index);
            }),
      ),
    );
  }

  //***FUNÇÕES****

  //ESTE WIDGET ESTÁ RETORNANDO O CARD QUE MOSTRARÁ A IMAGEM, NOME, EMAIL E TELEFONE
  Widget contactCard(BuildContext context, int index) {
    //este GestureDetector foi usado para que seja possível clicar no card a fim de editá-lo
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              //este Container foi criado para mostrar a imagem na dimensão que foi definida
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null
                        ? FileImage(File(contacts[index].img!))
                        : AssetImage("imagens/person.png"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contacts[index].name ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contacts[index].email ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      contacts[index].phone ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
