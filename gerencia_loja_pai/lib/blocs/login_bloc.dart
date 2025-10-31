import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_loja_pai/blocs/validator_login_screen.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase with ValidaLoginScreen{

  //CONSTRUTOR
  LoginBloc(super.state);
  
  //CONTROLLERS
  final userControl = BehaviorSubject<String>();
  final passControl = BehaviorSubject<String>();
  final loadingControl = BehaviorSubject<bool>();

  //STREAMS
  Stream get outUser => userControl.stream.transform(validarUser);
  Stream get outPass => passControl.stream.transform(validarPass);
  Stream get outLoading => loadingControl.stream;

  //SINKS
  Sink get inUser => userControl.sink;
  Sink get inPass => passControl.sink;
  Sink get inLoading => loadingControl.sink;

  //FUNÇÕES DE LOGAR NO SISTEMA
  Future<void> logar(BuildContext context) async{
    //pegando os valores das controllers e atrelando à variaveis do escopo local
    String user = userControl.value;
    String pass = passControl.value;

    //verificando se há valores dentro das variaveis a fim de fazer o login
    if( user.isNotEmpty && pass.isNotEmpty ){
      inLoading.add(true);

      await Future.delayed(Duration(seconds: 5));

      inLoading.add(false);
    }
  }

}