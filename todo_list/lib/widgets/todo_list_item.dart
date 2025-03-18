import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:intl/intl.dart";
import "package:todo_list/models/todo.dart";

//Sempre que for receber um parâmetro, faremos isso via construtor
//Foi criado um widget como stateless, pois não terá alteração no decorrer do código
class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.onDelete
  });

  //Atributos da classe
  final Todo todo;
  final Function(Todo) onDelete; //No caso da função, passamos o tipo do atributo e NÃO O ATRIBUTO EM SI

  @override
  Widget build(BuildContext context) {
    //Para criação de um novo widget(personalizavel), usamos dentro de um container
    //Este construtor Slidable é aquele que fará o efeito de arrastar o item para o lado mostrando as opções(em forma de ícone) do que fazer depois
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        actionExtentRatio: 0.25,
        //Este actionPane é a ação que fará, que neste caso foi escolhido este SlidableDrawerActionPane() para um efeito mais amigavel
        actionPane: SlidableDrawerActionPane(),
        //Este parâmetro secondaryActions serão os botões exibidos do lado direito do item
        //Há o parâmetro actions que mostrar os botãos do lado esquerdo do item
        secondaryActions: [
          //Para adicionar mais de um botão, fica deste jeito aqui embaixo
          IconSlideAction(
            color: Colors.red,
            icon: Icons.delete,
            caption: "Deletar",
            onTap: () {
              onDelete(todo);
            },
          ),
          /*IconSlideAction(
            color: Colors.blue,
            icon: Icons.edit,
            caption: "Editar",
            onTap: (){
              print("Editando");
            },
          )*/
        ],
        child: Container(
          //Este margin está dando espaço entre as caixas
          //margin: const EdgeInsets.symmetric(vertical: 2),

          //Este decoration está criando um pequena caixa com o fundo cinza
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            //Este elemento faz com que o item fique horizontalmente alinhado(start - esquerda, center - centro, end - direita); também conhecido como eixo cruzado
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //Em específico este .stretch faz o elemento ocupar a linha até o seu máximo
            children: [
              Text(
                //Formatando data no padrão pt-br; mas para isso deve importar o intl dentro do pubspec.yaml
                DateFormat('dd/MM/yyyy - HH:mm').format(todo.dateTime),
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                todo.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
