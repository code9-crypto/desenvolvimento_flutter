import 'dart:io';

import 'package:agenda_de_contatos/classes/contact_helper.dart';
import 'package:agenda_de_contatos/classes/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions {orderaz, orderza} //este enumerador será usado para fazer a ordernação entre os nomes

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
          //este icontheme permite fazer a estilização dos botões que ficam na appBar
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          actions: [
            //Este PopupMenuButton são os 3 pontos que fica na appBar e será usado para fazer a ordenação entre os nomes
            PopupMenuButton(
                itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                  const PopupMenuItem(
                      child: Text("Ordernar de A-Z"),
                      value: OrderOptions.orderaz,
                  ),
                  const PopupMenuItem(
                    child: Text("Ordernar de Z-A"),
                    value: OrderOptions.orderza,
                  )
                ],
                onSelected: orderList,
            )
          ],
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
            showContactPage(); //chamando a função que fará a transição das telas sem passar parâmetros
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
              return contactCard(context,
                  index); //aqui vai o widget customizavel que criamos ali embaixo
            }),
      ),
    );
  }

  //***FUNÇÕES****

  //ESTA FUNÇÃO SERÁ CHAMADA PARA FAZER A ORDENAÇÃO ENTRE OS NOMES DA LISTA
  void orderList(OrderOptions result){
    switch(result){
      case OrderOptions.orderaz:
        contacts.sort!((a,b){
          return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
          throw("Um dos nomes era nulo");
        });
        break;
      case OrderOptions.orderza:
        contacts.sort((a,b){
          return b.name!.toLowerCase().compareTo(a.name!.toLowerCase());
          throw("Um dos nomes era nulo");
        });
        break;
    }
    setState(() {

    });
  }

  //ESTA FUNÇÃO IRÁ ACESSAR O BANCO POR MEIO DA INSTANCIA HELPER, PEGAR OS DADOS E ATRIBUIR À VARIAVEL DO TIPO LISTA CONTATOS
  void getAllContacts() {
    helper.getAllContacts().then((data) {
      setState(() {
        contacts = data;
      });
    });
  }

  //ESTE FUNÇÃO ESTÁ SENDO USADA PARA FAZER A TRANSIÇÃO DAS TELAS
  //OBS.: esta função é interessante porque eu posso chamá-la passando parâmetros ou não; de qualquer formar que for chamada, vai funcionar
  void showContactPage({Contact? contact}) async {
    //Este Navigator.push está recebendo os dados devolvidos do Navigator.pop para depois salvá-los no banco
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactPage(contact: contact)));
    //aqui está verificando se a variável recContact se está vazio ou não; se não estiver vazia significa que vai salvar os dados ou vai atualizar
    if (recContact != null) {
      //Este contact vai verificar se a classe está populada com algum valor;  se estiver significa que vai atualizar(cair no helper.updateContact()), se não significa que está vazia e vai salvar novo(cair no helper.saveContact())
      if (contact != null) {
        await helper.updateContact(recContact);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Contato atualizado com sucesso"),
          duration: Duration(seconds: 3),
        ));
      } else {
        await helper.saveContact(recContact);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Contato salvo com sucesso"),
          duration: Duration(seconds: 3),
        ));
      }
      getAllContacts();
    }
  }

  //ESTA FUNÇÃO IRÁ MOSTRAR UMA PEQUENA JANELA QUE VAI APARECER DE BAIXO PRA CIMA COM AS OPÇÕES: LIGAR, EDITAR E EXCLUIR
  void showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                          onPressed: () {
                            launch("tel: ${contacts[index].phone}");
                            Navigator.pop(context);
                          },
                          child: Text(
                            "ligar",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showContactPage(contact: contacts[index]);
                          },
                          child: Text(
                            "Editar",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    title: Text("Excluir contato?"),
                                    content: Text("Deseja realmente excluir este contato?"),
                                    actions: [
                                      TextButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: Text("Não")
                                      ),
                                      TextButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                            helper.deleteContact(contacts[index].id!);
                                            setState(() {
                                              contacts.removeAt(index);
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Text("Sim")
                                      )
                                    ],
                                  );
                                }
                            );
                          },
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        });
  }

  //ESTE WIDGET ESTÁ RETORNANDO O CARD QUE MOSTRARÁ A IMAGEM, NOME, EMAIL E TELEFONE
  Widget contactCard(BuildContext context, int index) {
    //este GestureDetector foi usado para que seja possível clicar no card a fim de abrir as opções de ligar, editar e excluir
    return GestureDetector(
      onTap: () {
        showOptions(context, index);
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
                    fit: BoxFit.cover //este comando faz com que a imagem aparece de forma cheia
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
