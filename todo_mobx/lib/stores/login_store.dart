import 'dart:io';

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
    print(carregando);

    await Future.delayed(const Duration(seconds: 3));

    carregando = false;
    print(carregando);
  }


  //Aqui é o retorno da combinação dos dois estados
  //será true se os estados atenderem aos critérios
  //caso contrário, será false
  @computed
  bool get isFormValid => email.length > 6 && password.length > 6;


  //aqui está retornando o valor da estado visivel
  @computed
  bool get isVisible => visivel;
}