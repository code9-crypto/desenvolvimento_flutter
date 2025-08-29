import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../validators/login_validators.dart';

class LoginBloc extends BlocBase with LoginValidators{

  //Contrutor
  LoginBloc(super._state);

  //CONTROLADORES
  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();

  //STREAMS
  //Aqui esses get's estão pegando a saída da stream
  //Nesses 2 métodos está acontecendo a mesma coisa que é o seguinte:
  /* Antes que a aplicação receba o dado, o método transform() recebe por parâmtro um StreamTransformer, que neste caso está sendo passado um objeto(deste tipo)
  que já foi declarado na classe LoginValidators. Depois que o entra no tubo do StreamTransform, será feito a validação deste; se for válido, então a saída será o valor em si
  se não, será um valor de erro
  */
  Stream<String> get outEmail => emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => passwordController.stream.transform(validatePassword);

  //Este get será usado para deixar o botão habilitado caso tenha dados nos dois campos; ou será desabilitado caso um dos dois(ou os dois) não tenha nenhum valor
  Stream<bool> get outSubmitValid => Rx.combineLatest2(
      outEmail, outPassword, (a,b) => true
  );

  //Toda vez que essas funções forem chamadas, elas irão adicionar o valor do campo no seu respectivo controlador
  Function(String) get changeEmail => emailController.sink.add;
  Function(String) get changePassword => passwordController.sink.add;

  //Este método dispose é usado para não deixar que ocorra uma sobrecarga de memória
  //Por isso que deve usar o close nos controladores
  @override
  void dispose(){
    emailController.close();
    passwordController.close();
  }
}
