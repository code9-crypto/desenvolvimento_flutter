import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/user_model.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //***VARIÁVEIS***
  final _formKey = GlobalKey<
      FormState>();
 // Para que seja possível fazer a validação, será necessário criar esta variavel recebendo um GlobalKey() do tipo FormState
  final emailController = TextEditingController();

  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                //OBS.: este método pushReplacement não sobrepoe a próxima tela, mas sim substitui de modo que, quando clicar no botão de voltar, irá voltar para a tela antes desta
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignupScreen())
                );
              },
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              if (model.isLoading)
                return Center(child: CircularProgressIndicator(),);

              return Form(
                key: _formKey,
                // É necessário que a variável do tipo GlobalKey(criada lá em cima) seja declarada no parâmetro key dentro do Form
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    //ESTE É O CAMPO DE EMAIL
                    TextFormField(
                      controller: emailController,
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
                      controller: passController,
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
                    //Este construtor Align(), vai alinhar o botão na direita
                    //ESTE É O BOTÃO DE ESQUECI MINHA SENHA
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Esqueci minha senha",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.black),
                        ),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      ),
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
                            model.signIn(
                                email: emailController.text,
                                pass: passController.text,
                                onSuccess: onSuccess,
                                onFail: onFail
                            );
                            _formKey.currentState!.reset(); //Este comando faz com que os campos sejam apagados
                          }
                        },
                        child: Text(
                          "ENTRAR",
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
        )
    );
  }

  void onSuccess() {
    Navigator.of(context).pop();
  }

  void onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Falha ao entrar"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      )
    );
  }
}
