import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

//ESTA CLASSE SERÁ RESPONSÁVEL POR MANTER OS DADOS DO USUÁRIO LOGADO
class UserModel extends Model{

  //Instancia SingleTon
  FirebaseAuth _auth = FirebaseAuth.instance;

  //Este será a variável do usuário. Se este estiver logado, então será preenchida; caso contrário, estará vazia.
  User? firebaseUser;

  //Esta variável conterá os dados: Nome, email e endereço
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  void signIn(){}

  void signUp({required Map<String, dynamic> signUpUser, required String pass, required VoidCallback onSuccess, required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners(); //Este notifyListeners irá notificar todos os ScopedModelDescendent para que há modificação

    //Criando o usuário
    _auth.createUserWithEmailAndPassword(
        email: signUpUser["email"],
        password: pass
    ).then((authResult)async{
      firebaseUser = authResult.user as User;

      //Salvando os de mais dados do usuário: Nome e endereço
      await _saveUserData(signUpUser);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });

  }

  void recoverPass(){

  }

  //Salvando os de mais dados do usuário
  Future _saveUserData(Map<String, dynamic> signUpUser) async {
    userData = signUpUser;
    await FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).set(userData);
  }

}