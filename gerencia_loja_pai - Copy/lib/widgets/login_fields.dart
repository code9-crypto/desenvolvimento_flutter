import 'package:flutter/material.dart';
import 'package:gerencia_loja_pai/blocs/login_bloc.dart';
import 'package:gerencia_loja_pai/widgets/customize_fields.dart';
import '../screens/signup_screen.dart';
import '../validators/fields_validators.dart';


class LoginFields extends StatelessWidget with FieldsValidators{

  //CONSTRUTOR
  LoginFields({super.key});

  //KEYS
  final formKey = GlobalKey<FormState>();

  //CONTROLLERS
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final loginBlc = LoginBloc(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, //esticando o eixo horizontal da coluna, permite que os botões ocupem todo o espaço disponível
          children: [
            //ESTE É O CAMPO DE LOGIN
            CustomizeFields(
              controller: userCtrl,
              label: "Usuário",
              keyBoard: TextInputType.text,
              choice: false,
              prefixIcon: Icon(Icons.person),
              stream: loginBlc.outUser,
              //validator: validaLogin,
            ),
            SizedBox(height: 30),
            //ESTE É O CAMPO DE SENHA
            CustomizeFields(
              controller: passCtrl,
              label: "Senha",
              //validator: validaSenha,
              keyBoard: TextInputType.text,
              choice: true,
              prefixIcon: Icon(Icons.password),
              stream: loginBlc.outPass,
            ),
            SizedBox(height: 10,),
            //ESTE É O BOTÃO QUE IRÁ REDIRECIONAR PARA TELA DE CADASTRO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Não possui conta na loja?"),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignupScreen())
                    );
                  },
                  child: Text(
                    "Clique aqui",
                    style: TextStyle(
                      color: Colors.purple
                    ),
                  ),
                )
              ]
            ),
            SizedBox(height: 40,),
            //ESTE É O BOTÃO QUE FARÁ O LOGIN
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
                //formKey.currentState!.validate();
                loginBlc.inUser.add(userCtrl.text);
                loginBlc.inPass.add(passCtrl.text);
                loginBlc.analisa();
              },
              child: Text("Logar")
            )
          ],
        ),
      ),
    );
  }
}
