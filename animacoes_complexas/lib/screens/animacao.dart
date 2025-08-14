import 'package:flutter/material.dart';

import '../classes/animated_logo.dart';

class Animacao extends StatefulWidget {
  const Animacao({super.key});

  @override
  State<Animacao> createState() => _AnimacaoState();
}

class _AnimacaoState extends State<Animacao> with SingleTickerProviderStateMixin {

  //Criando o controlador do tipo AnimationController
  late AnimationController controller;
  late Animation<double> animation; //O tipo da Classe abstrata Animation pode animar qualquer coisa, neste caso vamos animar um double

  //Inicializando o controlador do AnimationController
  @override
  void initState() {
    super.initState();
    controller = AnimationController( //este controller varia a numeração/controlador entre 0 e 1.0
      vsync: this,
      duration: Duration(milliseconds: 500) //este duration é a parte que deixa a animação mais rápida ou mais lenta, de acordo com a unidade tempo
    );

    //A variável animation está recebendo a classe Tween, onde essa classe vai variar entre 0 e 300, mas com o controle da variavel controller
    //OBS.: aqui estamos usando o efeito cascata, ou seja, usando os métodos sem ficar repetindo o nome da variável
    //E como a gente está usando uma classe separada, a qual foi herdada pela classe AnimatedWidget, não será necessário o addListener com o setState
    animation = Tween<double>(begin: 50, end: 100).animate(controller);/*..addListener((){ //este listener ficará escutando quando a animação tiver alteração no valor para depois redesenhar a tela

    });*/

    /*//este listener ficará escutando quando a animação tiver alteração valor para depois redesenhar a tela
    animation.addListener((){
      setState(() {

      });
    });*/

    //Aqui é chamado toda vez quando o estado do animation muda
    animation.addStatusListener((status){
      //Este if fará com que a animação fique num loop infinito de frente para trás
      if( status == AnimationStatus.completed ){ //aqui verifica se o status da animação chegou ao fim(de trás para frente)
        controller.reverse(); //depois que a animação tiver sido finalizada, então o controller fará com que a animação anime de forma reversa
      } else if( status == AnimationStatus.dismissed ) { //aqui verifica se o status da animação chegou ao fim(da frente para trás)
        controller.forward(); //aqui fará a animação iniciar de forma normal
      }
    });

    //Iniciando a animação
    controller.forward();
  }

  //Este dispose irá encerrar o processo para não ficar consumindo recurso do dispositivo
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo<Animation<double>>(animation);
  }
}
