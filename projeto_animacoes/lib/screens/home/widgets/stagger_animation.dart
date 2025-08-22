import 'package:flutter/material.dart';
import 'package:projeto_animacoes/screens/home/widgets/animated_list_view.dart';
import 'package:projeto_animacoes/screens/home/widgets/home_top.dart';

//ESTA CLASSE É A RESPONSÁVEL DE TODA A CONFIGURAÇÃO DA ANIMAÇÃO
//IMPORTANTE: A ANIMAÇÃO NÃO ESTÁ ACONTECENDO AQUI, ELA ACONTECERÁ NA TELA/CLASSE QUE IMPORTAR ESTA CLASSE AQUI
class StaggerAnimation extends StatelessWidget {

  late final AnimationController controller;
  final Animation<double> containerGrow;
  final Animation<EdgeInsets> listSlidePosition;

  StaggerAnimation({required this.controller}) :
    containerGrow = CurvedAnimation(
        parent: controller,
        curve: Curves.ease
    ),

    listSlidePosition = EdgeInsetsTween(
      begin: EdgeInsets.only(bottom: 0),
      end: EdgeInsets.only(bottom: 80)
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.325, 0.8, curve: Curves.ease)
      )
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child){
            return ListView(
              padding: EdgeInsets.zero, //tirando todo afastamento que vem por padrão na listaView
              children: [
                HomeTop(
                  containerGrow: containerGrow,
                ),
                AnimatedListView(
                  listSlidePosition: listSlidePosition,
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
