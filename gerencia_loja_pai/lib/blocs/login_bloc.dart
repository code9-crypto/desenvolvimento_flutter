import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_loja_pai/blocs/validator_login_screen.dart';
import 'package:gerencia_loja_pai/screens/admin_screen.dart';
import 'package:gerencia_loja_pai/screens/home_screen.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase with ValidaLoginScreen{

  //CONSTRUTOR
  LoginBloc(super.state){
    //isLoggedIn(); //aqui o construtor ta verificando se o usuário já está logado ou não por meio deste método
  }

  //CONSTANTES
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  
  //CONTROLLERS
  final userControl = BehaviorSubject<String>();
  final passControl = BehaviorSubject<String>();
  final loadingControl = BehaviorSubject<bool>();
  final loggedIn = BehaviorSubject<bool>();
  final adminControl = BehaviorSubject();
  final userID = BehaviorSubject();

  //STREAMS
  Stream get outUser => userControl.stream.transform(validarUser);
  Stream get outPass => passControl.stream.transform(validarPass);
  Stream get outLoading => loadingControl.stream;
  Stream<bool> get outLoggedIn => loggedIn.stream;
  Stream get outAdmin => adminControl.stream;
  Stream get outUserID => userID.stream;

  //SINKS
  Sink get inUser => userControl.sink;
  Sink get inPass => passControl.sink;
  Sink get inLoading => loadingControl.sink;
  Sink get inLoggedIn => loggedIn.sink;
  Sink get inAdmin => adminControl.sink;
  Sink get inUserID => userID.sink;

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
      ).then((authResult) async{
        DocumentSnapshot? adminID = await firebase.collection("admins").doc(authResult.user!.uid).get();

        //Aqui está verificando se o login é do administrador/gerente ou usuário comum
        //Isso será de acordo com o valor dentro da variável adminID o qual está sendo verificado dentro da coleção admins
        if( adminID.exists ){
          inAdmin.add(true);
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          msgLogado("Gerente logado com sucesso!!!", context);
          Navigator.of(context).pushAndRemoveUntil( //este redicionamento, manda para a tela de administrador e remove a pilha anterior
            MaterialPageRoute(builder: (context) => AdminScreen()),
            (route) => false
          );
        } else {
          inUserID.add(auth.currentUser!.uid);
          inLoggedIn.add(true);
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          msgLogado("Logado com sucesso!!!", context);
          Navigator.of(context).pop();
        }

      }).catchError((onError){
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
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

  //aqui está apresentando a mensagem quando um usuário comum ou gerente tiver sucesso no login
  Widget? msgLogado(String texto, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.green,
          content: Text(texto, style: TextStyle(color: Colors.white),)
      )
    );
  }

}