import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:intl/intl.dart";
import "package:todo_list/models/todo.dart";

//Sempre que for receber um parâmetro, faremos isso via construtor
//Foi criado um widget como stateless, pois não terá alteração no decorrer do código
class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, required this.todo, required this.funcDelete});

  //Atributos da classe
  final Todo todo;
  final Function(Todo) funcDelete; //No caso da função, passamos o tipo do atributo e NÃO O ATRIBUTO EM SI

  @override
  Widget build(BuildContext context) {
    //Para criação de um novo widget(personalizavel), usamos dentro de um container
    //Este construtor Slidable é aquele que fará o efeito de arrastar o item para o lado mostrando as opções(em forma de ícone) do que fazer depois
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        //Esse Slidable é da versão 3.1.2
        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: ListTile(
          title: Text(todo.title, style: TextStyle(fontWeight: FontWeight.w700),),
          subtitle: Text(DateFormat('dd/MM/yyyy - HH:mm').format(todo.data), style: TextStyle(fontSize: 13),),
        ),
        //Este endActionPane é o elemento que fará com que o item seja arrastado da direita para esquerda e mostrará os ícones no lado direito
        endActionPane: ActionPane(
          //Este parâmetro motion é a forma de como será o efeito do slide
          motion: DrawerMotion(),
          children: [
            //Este construtor SlidableAction é o botão que será exibido quando o usuário arrastar o item
            //Normalmente vem com a ação do botão - onPressed - e depois vêm os parâmetros para estilizar o botão como ícone e cores
            SlidableAction(
              // An action can be bigger than the others.
              onPressed: (context) {
                funcDelete(todo);
              },
              backgroundColor: const Color(0xFFf42d2d),
              //este parâmetro da cor ao fundo do ícone
              foregroundColor: Colors.white,
              //este parâmetro da cor ao ícone
              icon: Icons.delete,
              label: 'Deletar',
            ),
            /*SlidableAction( para adicionar é deste jeito
              onPressed: (context) {
                print("agora cliquei no botão de save");
              },
              backgroundColor: Color(0xFF0392CF),
              foregroundColor: Colors.white,
              icon: Icons.save,
              label: 'Save',
            )*/
          ],
        ), //Esse Slidable é da versão 3.1.2
      ),
    );
  }
}
