import 'package:flutter/material.dart';
import 'package:loja_virutal_pai/validators/fields_validators.dart';
import 'package:loja_virutal_pai/widgets/customize_fields.dart';

class SignupScreen extends StatelessWidget with FieldsValidators{
  //VARIAVEIS
  final formKey = GlobalKey<FormState>();

  //CONSTRUTOR
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  label: "Nome completo",
                  validator: validaNome,
                  keyBoard: TextInputType.text,
                  choice: false,
                ),
                SizedBox(height: 16,),
                //CAMPO DO TELEFONE
                CustomizeFields(
                  label: "Celular / WhatsApp",
                  validator: validaTelefone,
                  keyBoard: TextInputType.number,
                  choice: false,
                ),
                SizedBox(height: 16,),
                //CAMPO DO NOME DO USUÁRIO
                CustomizeFields(
                  label: "Nome do usuário para entrar no sistema",
                  validator: validaUsuario,
                  keyBoard: TextInputType.text,
                  choice: false,
                ),
                SizedBox(height: 16,),
                CustomizeFields(
                  label: "Senha do usuário para entrar no sistema",
                  validator: validaSenha,
                  keyBoard: TextInputType.text,
                  choice: true,
                ),
                SizedBox(height: 40,),
                //ESTE É O BOTÃO QUE FARÁ O CADASTRO
                ElevatedButton(
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
                  onPressed: (){
                    formKey.currentState!.validate();
                  },
                  child: Text("Cadastrar")
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
