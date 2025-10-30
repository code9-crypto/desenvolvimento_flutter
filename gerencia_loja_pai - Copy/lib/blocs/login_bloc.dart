import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_loja_pai/blocs/validator_credentials.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase with ValidatorCredentias{

  LoginBloc(super.state);

  //CONTROLLERS
  final userController = BehaviorSubject<String>();
  final passController = BehaviorSubject<String>();

  //SAIDAS
  Stream<String> get outUser => userController.stream.transform(validUser);
  Stream<String> get outPass => passController.stream.transform(validPass);

  //ENTRADAS
  Sink get inUser => userController.sink;
  Sink get inPass => passController.sink;

  void analisa(){
    if( passController.hasValue ){
      print(passController.value);
    }else{
      print(passController.errorOrNull);
    }
  }

}