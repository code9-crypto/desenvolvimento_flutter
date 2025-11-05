//ESTA É A CLASSE QUE FARÁ AS VALIDAÇÕES DE TODOS OS CAMPOS DO APP SEJA DE QUAL TELA FOR
mixin class FieldsValidators{


  String? validaLogin(String? login){
    if( login!.isEmpty ) return "Por favor, digite seu usuário";
    return null;
  }


  String? validaSenha(String? senha){
    if( senha!.isEmpty ) return "Por favor, digite sua senha";
    return null;
  }

  String? validaNome(String? nome){
    if( nome!.isEmpty ) return "Por favor, digite seu nome completo";
    return null;
  }

  String? validaTelefone(String? telefone){
    if( telefone!.isEmpty ){
      return "Por favor, digite seu telefone";
    } else if( telefone.length < 11 ){
      return "Digite o seu número do whatsapp com DDD";
    }
    return null;
  }

  String? validaUsuario(String? usuario){
    if( usuario!.isEmpty ) return "Por favor, digite seu nome de usuario";
    return null;
  }

}