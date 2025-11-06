//ESTA É A CLASSE QUE FARÁ AS VALIDAÇÕES DE TODOS OS CAMPOS DA TELA DE CADASTRAR
mixin class FieldsValidators{

  String? validaSenha(String? senha){
    if( senha!.isEmpty ) return "Por favor, digite uma senha para entrar no sistema";
    return null;
  }

  String? validaNome(String? nome){
    if( nome!.isEmpty ) return "Por favor, digite seu nome completo";
    return null;
  }

  String? validaTelefone(String? telefone){
    if( telefone!.isEmpty ){
      return "Digite o seu número do whatsapp com DDD";
    }
    return null;
  }

  String? validaUsuario(String? usuario){
    if( usuario!.isEmpty ) return "Por favor, digite um email para entrar no sistema";
    return null;
  }

}