import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../validators/login_validators.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL } //ESSES SÃO OS ESTADOS DO LOGIN

class LoginBloc extends BlocBase with LoginValidators{

  //CONSTANTES
  FirebaseAuth auth = FirebaseAuth.instance; //esta constante é para ser usada em autenticação
  FirebaseFirestore banco = FirebaseFirestore.instance; //esta constante é para ser usada no acesso ao banco

  //********************************************************************************************************************************************************************

  //VARIÁVEIS
  late final StreamSubscription stSubs;

  //********************************************************************************************************************************************************************

  //CONSTRUTORES
  LoginBloc(super._state){
    //Aqui o app já vai verificar se está logado ou não; e também vai detectar se o usuário fez o login pelo login e senha
    stSubs = FirebaseAuth.instance.authStateChanges().listen((user) async {
      if( user != null ){
       if( await verifyPrivileges(user) ){
         inState.add(LoginState.SUCCESS);
         inStaticState.add(LoginState.SUCCESS);
       }else{
         auth.signOut();//deve ser usado este signOut(), porque o sistema já detectou que último usuário está logado
         inState.add(LoginState.FAIL);
         inStaticState.add(LoginState.FAIL);
       }
      }else{
        inState.add(LoginState.IDLE);
        inStaticState.add(LoginState.IDLE);
      }
    });

  }

  //********************************************************************************************************************************************************************

  //CONTROLADORES
  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();
  final stateController = BehaviorSubject<LoginState>();
  static final staticStateController = BehaviorSubject<LoginState>();

  //********************************************************************************************************************************************************************

  //STREAMS DE SAÍDA

  //Aqui esses get's estão pegando a saída da stream
  //Nesses métodos está acontecendo a mesma coisa que é o seguinte:
  /* Antes que a aplicação receba o dado, o método transform() recebe por parâmtro um StreamTransformer, que neste caso está sendo passado um objeto(deste tipo)
  que já foi declarado na classe LoginValidators. Depois que o entra no tubo do StreamTransform, será feito a validação deste; se for válido, então a saída será o valor em si
  se não, será um valor de erro
  */
  Stream<String> get outEmail => emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => passwordController.stream.transform(validatePassword);
  Stream<LoginState> get outState => stateController.stream;
  static Stream<LoginState> get outStaticState =>  staticStateController.stream; //esta saída está sendo atribuída a classe e NÃO AO OBJETO

  //Este get será usado para deixar o botão habilitado caso tenha dados nos dois campos; ou será desabilitado caso um dos dois(ou os dois) não tenha nenhum valor
  Stream get outSubmitValid => Rx.combineLatest2(
      outEmail, outPassword, (a,b) => true
  );

  //********************************************************************************************************************************************************************

  //STREAMS DE ENTRADA
  Sink get inState => stateController.sink;
  static Sink get inStaticState => staticStateController.sink; //esta entrada está sendo atribuída a classe e NÃO AO OBJETO

  //********************************************************************************************************************************************************************


  //FUNÇÕES ONCHANGE PARA OS CAMPOS DE TEXTO

  //Toda vez que essas funções forem chamadas, elas irão adicionar o valor do campo no seu respectivo controlador
  Function(String) get changeEmail => emailController.sink.add;
  Function(String) get changePassword => passwordController.sink.add;


  //********************************************************************************************************************************************************************

  //Este método dispose é usado para não deixar que ocorra uma sobrecarga de memória
  //Por isso que deve usar o close nos controladores
  @override
  void dispose(){
    emailController.close();
    passwordController.close();
    stateController.close();
    staticStateController.close();
    stSubs.cancel();
  }

  //********************************************************************************************************************************************************************

  //FUNÇÕES PARA AS AÇÕES DOS BOTÕES

  //função de fazer login
  void submit(){
    //Pegando usuário e senha por meio da StreamController
    String email = emailController.value;
    String pass = passwordController.value;

    //Avisando tela da mudança de estado
    inState.add(LoginState.LOADING);
    inStaticState.add(LoginState.LOADING);


    //Autenticando no firebase
    auth.signInWithEmailAndPassword(
        email: email,
        password: pass
    ).then((usr){
      inState.add(LoginState.SUCCESS);
      inStaticState.add(LoginState.SUCCESS);
    }).catchError((erro){
      inState.add(LoginState.FAIL);
      inStaticState.add(LoginState.FAIL);
    });
  }

  //verifica se o usuário tem permissão para acessar a área de administrador
  //OBS.: para retornar os valores das funções anônimas, use esta estrutura
  Future<bool> verifyPrivileges(User user) async{
    return await banco.collection("admins").doc(user.uid).get().then((doc){
      if( doc.data() != null ){
        return true;
      }else{
        return false;
      }
    }).catchError((e){
      return false;
    });
  }
}
