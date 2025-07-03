import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {

  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //***VARIÁVEIS***

  // Para que seja possível fazer a validação, será necessário criar esta variavel recebendo um GlobalKey()
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();//Para ter acesso ao estado do Scaffold

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if( model.isLoading )
            return Center(child: CircularProgressIndicator(),);

          return Form(
            // É necessário que a variável do tipo GlobalKey(criada lá em cima) seja declarada no parâmetro key dentro do Form
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                //ESTE É O CAMPO NOME
                TextFormField(
                  controller: _nameController,
                  autofocus: true,
                  //Este parâmetro nomeado validator, será usado para fazer a validação do email
                  validator: (nome) {
                    if (nome!.isEmpty) {
                      return "Nome inválido";
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  //A configuração do campo de texto, fica dentro deste decoration: InputDecoration()
                  decoration: InputDecoration(
                      hintText: "fulano de tal",
                      //aqui é o item que mostra uma dica do campo(semelhante a um placeholder)
                      labelText:
                      "Nome completo" // aqui é o item que mostra o texto antes de ser clicado
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                //ESTE É O CAMPO DE EMAIL
                TextFormField(
                  controller: _emailController,
                  autofocus: true,
                  //Este parâmetro nomeado validator, será usado para fazer a validação do email
                  validator: (email) {
                    if (email!.isEmpty || !email.contains("@")) {
                      return "E-mail inválido";
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  //A configuração do campo de texto, fica dentro deste decoration: InputDecoration()
                  decoration: InputDecoration(
                      hintText: "fulano@email.com",
                      //aqui é o item que mostra uma dica do campo(semelhante a um placeholder)
                      labelText:
                      "Digite seu email" // aqui é o item que mostra o texto antes de ser clicado
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                //ESTE É O CAMPO DE SENHA
                TextFormField(
                  controller: _passController,
                  validator: (senha) {
                    if (senha!.isEmpty || senha.length < 6) {
                      return "Senha inválida";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "********",
                      //aqui é o campo que mostra uma dica do campo
                      labelText: "Digite sua senha"),
                  obscureText: true,
                  obscuringCharacter: "*",
                ),
                SizedBox(
                  height: 16.0,
                ),
                //ESTE É O CAMPO ENDEREÇO
                TextFormField(
                  controller: _addressController,
                  validator: (end) {
                    if (end!.isEmpty) {
                      return "Endereço inválido";
                    }
                  },
                  decoration: InputDecoration(labelText: "Digite endereço"),
                ),
                SizedBox(
                  height: 16.0,
                ),
                //Este SizedBox está sendo usado para deixa o botão mais alto, por causa da propriedade height
                //ESTA É A PARTE DO BOTÃO DE ENTRAR
                SizedBox(
                  height: 64.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme
                          .of(context)
                          .primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    //Aqui neste onPressed é possível fazer a validação no form, pois: Foi criado a GlobalKey, declarado dentro da key no Form e criado o validator em cada TextFormField
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {

                        //Pegando as informações do campos e inserindo no mapa userData
                        Map<String, dynamic> userData = {
                          "name": _nameController.text.trim(),
                          "email": _emailController.text.trim(),
                          "address": _addressController.text.trim()
                        };

                        //Chamando a função signUp do UserModel por meio do model
                        model.signUp(signUpUser: userData, pass: _passController.text, onSuccess: _onSuccess, onFail: _onFail);

                        _formKey.currentState!.reset(); //Este comando faz com que os campos sejam apagados
                      }
                    },
                    child: Text(
                      "Criar conta",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }

  //***FUNÇÕES***
  void _onSuccess(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Usuário criado com sucesso"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      )
    );
    //Depois de 2 segundos vai executar esta função
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Falhar ao criar usuário"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }
}
