import 'dart:io';

import 'package:agenda_de_contatos/classes/contact_helper.dart';
import 'package:agenda_de_contatos/classes/contact_page.dart';
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
    getAllContacts();
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
          onPressed: () {
            showContactPage(); //chamando a função de transição das telas sem passar parâmetros
          },
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
              return contactCard(context, index); //aqui vai o widget customizavel que criamos ali embaixo
            }),
      ),
    );
  }

  //***FUNÇÕES****

  //ESTA FUNÇÃO IRÁ ACESSAR O BANCO POR MEIO DA INSTANCIA HELPER, PEGAR OS DADOS E ATRIBUIR À VARIAVEL DO TIPO LISTA CONTATOS
  void getAllContacts(){
    helper.getAllContacts().then((data) {
      setState(() {
        contacts = data;
      });
    });
  }

  //ESTE FUNÇÃO ESTÁ SENDO USADA PARA FAZER A TRANSIÇÃO DAS TELAS
  //OBS.: esta função é interessante porque eu posso chamá-la passando parâmetros ou não; de qualquer formar que for chamada, vai funcionar
  void showContactPage({Contact? contact}) async{
    //Este Navigator.push está recebendo os dados devolvidos do Navigator.pop para depois salvá-los no banco
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactPage(contact: contact)
        )
    );
    //aqui está verificando se a variável recContact se está vazio ou não; se não estiver vazia significa que vai salvar os dados ou vai atualizar
    if( recContact != null ){
      //Este contact vai verificar se a classe está populada com algum valor;  se estiver significa que vai atualizar(cair no helper.updateContact()), se não significa que está vazia e vai salvar novo(cair no helper.saveContact())
      if( contact != null ){
        await helper.updateContact(recContact);
      }else{
        await helper.saveContact(recContact);
      }
      getAllContacts();
    }
  }

  //ESTE WIDGET ESTÁ RETORNANDO O CARD QUE MOSTRARÁ A IMAGEM, NOME, EMAIL E TELEFONE
  Widget contactCard(BuildContext context, int index) {
    //este GestureDetector foi usado para que seja possível clicar no card a fim de editá-lo
    return GestureDetector(
      onTap: (){
        showContactPage(contact: contacts[index]); //aqui estou chamando a função que faz a transição das telas e passando os dados referente àquele índice clicado
      },
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
