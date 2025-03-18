import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  //Este é o controlador do campo para adicionar tarefas
  final TextEditingController tasksController = TextEditingController();

  List<String> tasks = [];

  //Esta é a instancia da classe controller para recuperar valores do campo de texto
  @override
  Widget build(BuildContext context) {
    return SafeArea( // Este faz com que o layout não encoste na área superior que é onde fica as notificações do celular
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Lista de tarefas",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: tasksController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Adicionar uma tarefa",
                            hintText: "Ex. estudar flutter"),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String text = tasksController.text;
                        setState(() {
                          tasks.add(text);
                        });
                        tasksController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(50, 50),
                        backgroundColor: Color(0xff00d7f3),
                        padding: EdgeInsets.all(10),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Flexible( //Esta função faz com que a lista fique do tamanho máximo da tela; A ListView() fica dentro da função Flexible()
                  child: ListView(
                    shrinkWrap: true, // Este elemento deixa a lista do tamanho de forma que caiba todos os itens da lista
                    children: [
                      for( String task in tasks )
                        TodoListItem(
                          //OBS.: aqui dentro sempre aparecerá os parâmetros nomeados que estiverem dentro do construtor
                          title: task,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Você possui ${tasks.length} tarefas pendentes",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          tasks.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: Size(105, 50),
                        backgroundColor: Color(0xff00d7f3),
                        padding: EdgeInsets.all(10),
                      ),
                      child: Text(
                        "Limpar tudo",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
