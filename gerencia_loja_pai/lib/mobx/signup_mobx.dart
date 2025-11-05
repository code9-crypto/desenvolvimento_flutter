import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'signup_mobx.g.dart';

class SignupMobx = _SignupMobx with _$SignupMobx;

abstract class _SignupMobx with Store{

  //CONSTANTES
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  //ESTADOS
  @observable
  String nome = "";
  @observable
  String celular = "";
  @observable
  String userEmail = "";
  @observable
  String userPass = "";
  @observable
  bool loading = false;

  //AÇÕES
  //esta ação será para fazer o cadastro no sistema
  @action
  Future<bool> createUser(String nm, String cel, String userE, String userP) async {
    loading = true;

    //recebendo os valores nos estados pelos parâmetros
    nome = nm;
    celular = cel;
    userEmail = userE;
    userPass = userP;

    //criando usuário no firebase
    await auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPass
    ).then((authResult){

      //inserindo os dados do usuário banco
      firebase.collection("users").add({
        "name" : nome,
        "cel" : celular,
        "email" : userEmail
      });

      loading = false;
      return true;
    }).catchError((onError){
      loading = false;
      return false;
    });

    return false;
  }
}