import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  //Este é o controlador do campo para adicionar tarefas
  final TextEditingController tasksController = TextEditingController();

  //A lista que será usada para adicionar os itens a lista
  List<Todo> tasks = [];

  Todo? deletedTodo; //esta variável irá armazenar as tarefas que foram deletadas
  int? deletedTodoPos; //esta variável irá armazenzar a posição da tarefa que foi deletada

  //Esta é a instancia da classe controller para recuperar valores do campo de texto
  @override
  Widget build(BuildContext context) {
    // Este faz com que o layout não encoste na área superior que é onde fica as notificações do celular
    return SafeArea(
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
                        //Deixo o controller dentro do textfied para que possa recuperar o valor escrito aqui dentro
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
                        //Aqui esta pegando o valor do campo de texto e armazenando dentro da variável text
                        String text = tasksController.text;
                        //verificando se não está vazio
                        if (text.isNotEmpty) {
                          setState(() {
                            //Instanciando a nova classe e adicionando a instancia na lista
                            Todo newTodo =
                                Todo(title: text, dateTime: DateTime.now());
                            //Aqui esta apenas mandando para lista... NÃO ESTÁ EXIBINDO NA TELA NADA
                            tasks.add(newTodo);
                          });
                          tasksController.clear();
                        }
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
                Flexible(
                  //Esta função faz com que a lista fique do tamanho máximo da tela; A ListView() fica dentro da função Flexible()
                  child: ListView(
                    shrinkWrap: true,
                    // Este elemento deixa a lista do tamanho de forma que caiba todos os itens da lista
                    children: [
                      //AQUI É A PARTE QUE ESTÁ EXIBINDO NA TELA O QUE ESTÁ DENTRO DA LISTA
                      //PERCORRENDO POR TODOS OS ITENS QUE ESTÃO DENTRO DA LISTA COM O for()
                      for (Todo task in tasks)
                        //Já dentro do for, estou chamando o novo widget criado e já passando o objeto task ao parâmetro nomeado do construtor dessa classe
                        //Esse TodoListItem é o construtor da própria classe
                        TodoListItem(
                          //OBS.: aqui dentro sempre aparecerá os parâmetros nomeados que estiverem dentro do construtor
                          //Passando os valores á classe do widget filho
                          todo: task,
                          funcDelete: onDelete,
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
                      onPressed: tasks.isNotEmpty ? mostrarMensagemApagarTudo : null, //verificando se a lista está vazia. Caso esteja o botão será desabilitado, se não o botão vai habilitar para apagar tudo
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: Size(105, 50),
                        backgroundColor: Color(0xff00d7f3),
                        padding: EdgeInsets.all(10),
                      ),
                      //Esse child é o parâmetro que vai dentro do botão; pode ser um ícone ou um texto
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

  /* --------- FUNÇÕES DO APLICATIVO ---------- */

  //Para que a classe Pai passe parâmetros para classe filho, cria-se uma função e dentro da classe filho recebe esta função como parâmetro

  //neste caso será para deletar
  void onDelete(Todo tf) {
    deletedTodo = tf;
    deletedTodoPos = tasks.indexOf(tf);

    setState(() {
      tasks.remove(tf);
    });

    ScaffoldMessenger.of(context)
        .clearSnackBars(); //este comando apaga o snackbar que está sendo exibido
    //Criando um SnackBar quando houver uma deleção
    //Esta é uma forma bem simples
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa ${tf.title} excluída com sucesso",
          style: TextStyle(color: Color(0xff060708)),
        ),
        backgroundColor: Colors.white,
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Color(0xff00d7f3),
          onPressed: () {
            setState(() {
              tasks.insert(deletedTodoPos!, deletedTodo!);
            });
          },
        ),
      ),
    );
  }

  //Esta função é usada para mostrar um alerta para o usuário
  void mostrarMensagemApagarTudo() {
    //mostrando o dialogo
    showDialog(
      context: context,
      //Este builder é onde faz a configuração de todo o dialogo
      builder: (context) => AlertDialog(
        title: Text("Limpar tudo?"),
        content: Text("Você tem certeza que deseja apagar todas as tarefas?"),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();//Esta função fecha o dialogo
            },
            style: TextButton.styleFrom(foregroundColor: Color(0xff00d7f3)),
            child: Text("Cancelar",),
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
              setState(() {
                tasks.clear();
              });
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text("Limpar tudo"),
          ),
        ],
      ),
    );
  }

}
