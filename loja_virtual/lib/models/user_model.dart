import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

//ESTA CLASSE SERÁ RESPONSÁVEL POR CUIDAR DAS FUNÇÕES DO USUÁRIO
class UserModel extends Model {

  //Instancia SingleTon
  FirebaseAuth _auth = FirebaseAuth.instance;

  //Este será a variável do usuário. Se este estiver logado, então será preenchida; caso contrário, estará vazia.
  User? firebaseUser;

  //Esta variável conterá os dados: Nome, email e endereço
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  //Para acessar as funções desta classe de qualquer lugar do app
  //Essa declaração fará isso e poderemos acessar de forma bem simples
  static UserModel of(BuildContext context) => ScopedModel.of<UserModel>(context);

  //Chamando a função assim que o aplicativo for iniciado
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  //Esta função está realizando o login no sistema
  void signIn({required String email, required String pass, required VoidCallback onSuccess, required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(
        email: email,
        password: pass
    ).then((authResult)async{
      firebaseUser = authResult.user;

      await _loadCurrentUser();

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e){

      onFail();
      isLoading = false;
      notifyListeners();
    });
  }


  //Está função está deslogando o usuário e resetando as variáveis userData e firebaseUser
  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  //Esta função está realizando o cadastro no sistema
  void signUp({required Map<String, dynamic> signUpUser, required String pass, required VoidCallback onSuccess, required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners(); //Este notifyListeners irá notificar todos os ScopedModelDescendent para que há modificação

    //Criando o usuário
    _auth.createUserWithEmailAndPassword(
        email: signUpUser["email"],
        password: pass
    ).then((authResult) async {
      firebaseUser = authResult.user as User;

      //Salvando os de mais dados do usuário: Nome e endereço
      await _saveUserData(signUpUser);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  //Esta função é responsável por fazer a recuperação de senha
  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  //Caso haja um usuário logado, esta função retornará true; caso contrário, retornará false.
  bool isLoogedIn() {
    return firebaseUser != null;
  }

  //Salvando os de mais dados do usuário
  Future _saveUserData(Map<String, dynamic> signUpUser) async {
    userData = signUpUser;
    await FirebaseFirestore.instance.collection("users")
        .doc(firebaseUser!.uid)
        .set(userData);
  }

  //Essa função carrega o usuário que já está logado
  Future _loadCurrentUser() async {
    if( firebaseUser == null ){
      firebaseUser = await _auth.currentUser;
    }

    if( firebaseUser != null ){
      if( userData["name"] == null){
        DocumentSnapshot docUser = await FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).get();
        userData = docUser.data() as Map<String, dynamic>;
      }
    }
    notifyListeners();
  }

}