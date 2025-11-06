//ESTA É A CLASSE QUE FARÁ AS VALIDAÇÕES DE TODOS OS CAMPOS DA TELA DE CADASTRAR
mixin class FieldsValidators{

  String? validaLogin(String? login){
    if( login!.isEmpty ) return "Por favor, digite seu email";
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