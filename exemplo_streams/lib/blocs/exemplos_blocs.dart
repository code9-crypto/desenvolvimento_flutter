import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class ExemplosBlocs extends BlocBase{

  ExemplosBlocs(super.state);

  //Instanciando um objeto do tipo BehaviorSubject
  final favoriteController = BehaviorSubject<int>();

  //funções da Stream de entrada e saída
  Stream get outFav => favoriteController.stream;//saída da stream
  Sink get inFav => favoriteController.sink;//entrada da stream

  //funções da classe
  void addFavorito(info){
    inFav.add(info);
  }

}