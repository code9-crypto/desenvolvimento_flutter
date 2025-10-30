import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store{

  _LoginStore(){

  }

  //Referente ao campo de email
  @observable
  String email = "";
  @action
  void setEmail(value) => email = value;

  //Referente ao campo de senha
  @observable
  String password = "";
  @action
  void setPass(pass) => password = pass;

  //Referente ao botão de visibilidade
  @observable
  bool visivel = false;
  @action
  void setVisivel() => visivel = !visivel;

  @observable
  bool carregando = false;
  @action
  Future<void> login() async{
    carregando = true;
    await Future.delayed(const Duration(seconds: 3));
    carregando = false;
    loggedIn = true;
  }

  //Este será o estado para quando o usuário estiver logado ou não
  @observable
  bool loggedIn = false;


  //Aqui é o retorno da combinação dos dois estados
  //será true se os estados atenderem aos critérios
  //caso contrário, será false
  @computed
  bool get isFormValid => email.length > 6 && password.length > 6;

  //aqui está retornando o valor da estado visivel
  @computed
  bool get isVisible => visivel;

  @computed
  bool get liberaBotao => isFormValid && !carregando;

  //deixando a lógica, que ficaria no onPressed do botão, aqui dentro do login_store.dart
  @computed
  VoidCallback? get loginPressed => liberaBotao ? login : null;

}