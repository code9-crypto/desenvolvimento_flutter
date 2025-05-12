import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ListaTarefas extends StatefulWidget {
  const ListaTarefas({super.key});

  @override
  State<ListaTarefas> createState() => _ListaTarefasState();
}

class _ListaTarefasState extends State<ListaTarefas> {

  // ***** VARIAÁVEIS ****
  List todoList = [];

  // **** CONTROLADORES DOS CAMPOS DE TEXTO ****
  final TextEditingController newTask = TextEditingController();

  //Chamando o método da leitura dos dados no início da inicialização do aplicativo
  @override
  void initState() {
    super.initState();
    //chamando a função _readData e dando um then, porque a função será chamada no futuro por isso do then
    //Depois estou decodificando o json e armazenando dentro da lista
    _readData().then((data) {
      todoList = json.decode(data!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Lista de Tarefas",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Divider(color: Colors.white),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      //Nunca esquecer de colocar o controlador dentro do campo TextField
                      controller: newTask,
                      decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addTodo();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      fixedSize: Size(100, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "ADD",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.white),
              Flexible(
                fit: FlexFit.tight,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: todoList.length,
                    itemBuilder: buildItem,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  // **** FUNÇÕES ****

  //Esta função irá pegar o arquivo que foi usado para salvar os dados
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  //Esta função está sendo usada para salvar os dados em forma json
  Future<File> _saveData() async {
    //Pegando a lista e formatando em json e atribuindo a uma string
    String data = json.encode(todoList);
    //Pegando o caminho do arquivo com a função _getFile()
    final file = await _getFile();
    //Escrevendo os dados dentro do arquivo
    return file.writeAsString(data);
  }

  //Esta função irá obter os dados do arquivo as quais estarão em formato json
  Future<String?> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  //Adicionando o valor na lista
  void _addTodo() {
    setState(() {
      Map<String, dynamic> newTodo = Map();
      newTodo["title"] = newTask.text;
      newTask.clear();
      newTodo["ok"] = false;
      todoList.add(newTodo);
      _saveData();
    });
  }


  // **** Widgets personalizaveis ****
  Widget buildItem(context, index) {
    //Este construtor Dismissible permite arrastar o item para fazer a deleção
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white,),
        ),
      ),
      direction: DismissDirection.startToEnd,
      //Este tipo de CheckboxLisTile irá fornecer um layout com ícones e um campo de checkbox
      child: CheckboxListTile(
        value: todoList[index]["ok"],
        title: Text(todoList[index]["title"]),
        //Este onChanged muda o estado na tela, quando marcado a caixa fica ticada e quando não a caixa fica em branco
        //Essa função sempre vai receber um parâmetro para ser trabalhado o check
        onChanged: (check) {
          setState(() {
            todoList[index]["ok"] = check;
            _saveData();
          });
        },
        secondary: CircleAvatar(
          child: Icon(todoList[index]["ok"]
              ? Icons.check
              : Icons.error),
        ),
      ),
    );
  }
}