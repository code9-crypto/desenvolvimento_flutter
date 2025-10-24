import 'package:mobx/mobx.dart';

class Counter{

  //Vinculando a ação com a função por meio do construtor
  Counter(){
    increment = Action(_increment);
  }

  //definindo o estado
  //todo estado é um Observable
  Observable _count = Observable(0);
  Observable texto = Observable("zero");

  //acessando e retornando o valor do estado por meio de um getter
  int get count => _count.value;
  String get txt => texto.value;

  //Definindo ação para incrementar o número e mudar o nome por extenso
  late Action increment;


  //função que será usada pela ação(increment) para modificação do estado
  //OBS.: aqui estou chamando outra função encadeada a fim de apenas em uma ação executar duas funções e ter duas reações ao mesmo tempo
  void _increment(){
    _count.value++;
    changeText(_count.value);
  }

  void changeText(valor){
    switch(valor){
      case 0:
        texto.value = "zero";
        break;
      case 1:
        texto.value = "um";
        break;
      case 2:
        texto.value = "dois";
        break;
      case 3:
        texto.value = "três";
        break;
      case 4:
        texto.value = "quatro";
        break;
      case 5:
        texto.value = "cinco";
        break;
      case 6:
        texto.value = "seis";
        break;
      case 7:
        texto.value = "sete";
        break;
      case 8:
        texto.value = "oito";
        break;
      case 9:
        texto.value = "nove";
        break;
      case 11:
        texto.value = "onze";
        break;
      case 12:
        texto.value = "doze";
        break;
      case 13:
        texto.value = "treze";
        break;
      case 14:
        texto.value = "quatorze";
        break;
      case 15:
        texto.value = "quinze";
        break;
      case 16:
        texto.value = "dezesseis";
        break;
    }
  }
}