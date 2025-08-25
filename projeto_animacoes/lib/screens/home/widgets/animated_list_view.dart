import 'package:flutter/material.dart';
import 'package:projeto_animacoes/screens/home/widgets/list_data.dart';

class AnimatedListView extends StatelessWidget {

  final Animation<EdgeInsets> listSlidePosition;

  AnimatedListView({required this.listSlidePosition});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListData(
          title: "Estudar HTML",
          subtitle: "Com o curso do Daniel Ciolfi",
          image: AssetImage("assets/perfil.jpg"),
          margin: listSlidePosition.value * 8,
        ),
        ListData(
          title: "Estudar flutter",
          subtitle: "Com o curso do Daniel Ciolfi",
          image: AssetImage("assets/perfil.jpg"),
          margin: listSlidePosition.value * 7,
        ),
        ListData(
          title: "Estudar flutter",
          subtitle: "Com o curso do Daniel Ciolfi",
          image: AssetImage("assets/perfil.jpg"),
          margin: listSlidePosition.value * 6,
        ),
        ListData(
          title: "Estudar flutter",
          subtitle: "Com o curso do Daniel Ciolfi",
          image: AssetImage("assets/perfil.jpg"),
          margin: listSlidePosition.value * 5,
        ),
        ListData(
          title: "Estudar flutter",
          subtitle: "Com o curso do Daniel Ciolfi",
          image: AssetImage("assets/perfil.jpg"),
          margin: listSlidePosition.value * 4,
        ),
        ListData(
          title: "Estudar HTML",
          subtitle: "Com o curso do Daniel Ciolfi",
          image: AssetImage("assets/perfil.jpg"),
          margin: listSlidePosition.value * 3,
        ),
        ListData(
          title: "Estudar flutter",
          subtitle: "Com o curso do Daniel Ciolfi",
          image: AssetImage("assets/perfil.jpg"),
          margin: listSlidePosition.value * 2,
        ),
        ListData(
          title: "Estudar flutter",
          subtitle: "Com o curso do Daniel Ciolfi",
          image: AssetImage("assets/perfil.jpg"),
          margin: listSlidePosition.value * 1,
        ),
        ListData(
          title: "Estudar flutter",
          subtitle: "Com o curso do Daniel Ciolfi",
          image: AssetImage("assets/perfil.jpg"),
          margin: listSlidePosition.value * 0,
        ),
      ],
    );
  }
}
