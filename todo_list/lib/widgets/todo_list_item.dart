import "package:flutter/material.dart";

//Sempre que for receber um parâmetro, faremos isso via construtor

class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        //Este elemento faz com que o item fique horizontalmente alinhado(start - esquerda, center - centro, end - direita); também conhecido como eixo cruzado
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "16/03/2023",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Text(
            "$title",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
