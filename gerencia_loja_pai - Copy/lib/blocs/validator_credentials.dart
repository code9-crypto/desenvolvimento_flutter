import 'dart:async';

mixin class ValidatorCredentias{

  final validUser = StreamTransformer<String, String>.fromHandlers(
    handleData: (user, sink){
      if( user.isNotEmpty ){
        sink.add(user);
      }else{
        sink.addError("Por favor, insira seu nome de usuário");
      }
    }
  );

  final validPass = StreamTransformer<String, String>.fromHandlers(
    handleData: (pass, sink){
      if( pass.isNotEmpty ){
        sink.add(pass);
      }else{
        sink.addError("Por favor, insira sua senha");
      }
    }
  );

}