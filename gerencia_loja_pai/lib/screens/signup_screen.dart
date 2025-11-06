import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerencia_loja_pai/mobx/signup_mobx.dart';

import '../validators/fields_validators.dart';
import '../widgets/customize_fields.dart';


class SignupScreen extends StatelessWidget with FieldsValidators{
  //VARIAVEIS
  final formKey = GlobalKey<FormState>();

  //CONSTRUTOR
  SignupScreen({super.key});

  //CONTROLLERS
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController celController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SignupMobx signupMobx = SignupMobx();

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar conta"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //CAMPO DO NOME
                CustomizeFields(
                  controller: nomeController,
                  label: "Nome completo",
                  validator: validaNome,
                  keyBoard: TextInputType.text,
                  choice: false,
                ),
                SizedBox(height: 16,),
                //CAMPO DO TELEFONE
                CustomizeFields(
                  controller: celController,
                  label: "Celular / WhatsApp",
                  validator: validaTelefone,
                  keyBoard: TextInputType.number,
                  choice: false,
                ),
                SizedBox(height: 16,),
                //CAMPO DO NOME DO USUÁRIO
                CustomizeFields(
                  controller: userController,
                  label: "Nome do usuário para entrar no sistema",
                  validator: validaUsuario,
                  keyBoard: TextInputType.text,
                  choice: false,
                ),
                SizedBox(height: 16,),
                CustomizeFields(
                  controller: passController,
                  label: "Senha do usuário para entrar no sistema",
                  validator: validaSenha,
                  keyBoard: TextInputType.text,
                  choice: true,
                ),
                SizedBox(height: 40,),
                //ESTE É O BOTÃO QUE FARÁ O CADASTRO
                Observer(
                  builder: (context){
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        textStyle: TextStyle(
                            fontSize: 25
                        )
                      ),
                      onPressed: ()async{
                        if( formKey.currentState!.validate() ){
                          bool check = await signupMobx.createUser(nomeController.text, celController.text, userController.text, passController.text);

                          if( check ){
                            mostraMensagem(context, "Cadastrado com sucesso!!!", Colors.green);
                          }else{
                            mostraMensagem(context, "Falha ao cadastrar", Colors.red);
                          }
                        }
                      },
                      child: signupMobx.loading ? SizedBox(height: 30, width: 30, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),),) : Text("Cadastrar")
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  //FUNÇÕES

  //esta será para apresentar uma mensagem ao usuário caso funcione o cadastramento ou não
  void mostraMensagem(BuildContext context, String texto, Color corFundo){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: corFundo,
        content: Text(
          texto,
          style: TextStyle(
            color: Colors.white
          ),
        )
      )
    );
  }
}
