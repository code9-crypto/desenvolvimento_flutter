import 'dart:async';

//ESTA CLASSE É RESPONSÁVEL POR FAZER A VALIDAÇÃO DO CAMPO EMAIL E SENHA
//ESTA CLASSE ESTÁ SENDO CHAMADA NA CLASSE LOGIN_BLOC
mixin class LoginValidators{

  /*Nota:
  O 1º parâmetro do StreamTransformer é o tipo de dado que vai entrar
  O 2º parâmetro do StreamTransformer é o tipo de dado que vai sair
  */
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      if( email.contains("@") ){
        sink.add(email);
      }else{
        sink.addError("Insira um e-mail válido");
      }
    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if( password.length > 4 ){
        sink.add(password);
      }else{
        sink.addError("A senha deve ser maior que 4 caracteres");
      }
    }
  );
}