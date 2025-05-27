import 'dart:io';
import 'package:flutter/material.dart';
import 'contact_helper.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  //VARIÁVEL
  final Contact? contact;

  //CONTRUTOR
  ContactPage({super.key, this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  //VARIÁVEIS
  Contact? editedContact;
  bool userEdited = false;

  //CONTROLADORES DOS CAMPOS
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  //FOCO DE CAMPO
  final nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      editedContact = Contact();
    } else {
      editedContact = Contact.fromMap(widget.contact!.toMap());
      nameController.text = editedContact!.name!;
      emailController.text = editedContact!.email!;
      phoneController.text = editedContact!.phone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => requestPop(), //aqui é a parte da seta que fica na appBar; Quando este botão for clicado será chamado esta função
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.red,
          title: Text(
            editedContact!.name ?? "Novo Contato",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          //Quando o botão de salvar for clicado, será feito uma verificação em cima do campo nome; se o campo nome não estiver preenchido então será dado um foco neste campo
          onPressed: () {
            if (nameController.text.isNotEmpty && nameController.text != null) {
              Navigator.pop(context,
                  editedContact); // este comando irá remover a tela e voltar à anterior; este Navigator.pop vai retonar à tela anterior com os dados do cadastro
            } else {
              FocusScope.of(context).requestFocus(nameFocus);
            }
          },
          child: Icon(
            Icons.save,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              //Aqui é a imagem que vai aparecer no topo do corpo da tela
              GestureDetector(
                //Este onTap fará com que quando o usuário clicar na imagem, será aberto a câmera para poder tirar foto
                onTap: (){
                  ImagePicker().pickImage(
                      source: ImageSource.camera
                  ).then((file){
                    if( file == null ){
                      return;
                    }else{
                      setState(() {
                        editedContact!.img = file.path;
                      });
                    }
                  });
                },
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: editedContact!.img != null
                          ? FileImage(File(editedContact!.img!))
                          : AssetImage("imagens/person.png"),
                      fit: BoxFit.cover
                    ),
                  ),
                ),
              ),
              TextField(
                controller: nameController,
                focusNode: nameFocus,
                onChanged: (text) {
                  userEdited = true;
                  setState(() {
                    editedContact!.name = text;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Nome",
                ),
              ),
              TextField(
                controller: emailController,
                onChanged: (text) {
                  userEdited = true;
                  editedContact!.email = text;
                },
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: phoneController,
                onChanged: (text) {
                  userEdited = true;
                  editedContact!.phone = text;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //FUNÇÕES

  //Esta função irá exibir um AlertDialog quando tentar voltar para tela anterior, quando fizer alguma alteração nos dados e não tiver completadas
  requestPop(){
    if( userEdited ){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Descartar alterações?"),
              content: Text("Se sair as alterações serão perdidas"),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Cancelar", style: TextStyle(color: Colors.red),)
                ),
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("Sim", style: TextStyle(color: Colors.blueAccent),)
                )
              ],
            );
          }
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

}
