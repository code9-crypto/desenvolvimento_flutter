import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_loja_pai/blocs/validator_login_screen.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase with ValidaLoginScreen{

  //CONSTRUTOR
  LoginBloc(super.state){
    isLoggedIn(); //aqui o construtor ta verificando se o usuário já está logado ou não por meio deste método
  }

  //CONSTANTES
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  //CONTROLLERS
  final userControl = BehaviorSubject<String>();
  final passControl = BehaviorSubject<String>();
  final loadingControl = BehaviorSubject<bool>();
  final loggedIn = BehaviorSubject<bool>();

  //STREAMS
  Stream get outUser => userControl.stream.transform(validarUser);
  Stream get outPass => passControl.stream.transform(validarPass);
  Stream get outLoading => loadingControl.stream;
  Stream<bool> get outLoggedIn => loggedIn.stream;

  //SINKS
  Sink get inUser => userControl.sink;
  Sink get inPass => passControl.sink;
  Sink get inLoading => loadingControl.sink;
  Sink get inLoggedIn => loggedIn.sink;

  //FUNÇÕES DE LOGAR NO SISTEMA
  Future<void> logar(BuildContext context) async{
    //pegando os valores das controllers e atrelando à variaveis do escopo local
    String user = userControl.value;
    String pass = passControl.value;

    //verificando se há valores dentro das variaveis a fim de fazer o login
    if( user.isNotEmpty && pass.isNotEmpty ){
      inLoading.add(true);

      await auth.signInWithEmailAndPassword(

          email: user,
          password: pass

      ).then((authResult){
        inLoggedIn.add(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Logado com sucesso!!!", style: TextStyle(color: Colors.white),)
          )
        );
        Navigator.of(context).pop();

      }).catchError((onError){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Houve uma falha ao se autenticar",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          )
        );
      });

      inLoading.add(false);
    }
  }

  //esta função irá verificar se o usuário está logado ou não
  //Se estiver logado então o valor será true
  //caso contrário será false
  void isLoggedIn(){
    if( auth.currentUser != null ){
      inLoggedIn.add(true);
    }else{
      inLoggedIn.add(false);
    }
  }

  //esta função irá sair do sistema
  void signOut(){
    inLoggedIn.add(false);
    auth.signOut();
  }

}