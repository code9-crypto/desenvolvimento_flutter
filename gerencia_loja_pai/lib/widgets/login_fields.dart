import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_loja_pai/screens/home_screen.dart';
import 'package:gerencia_loja_pai/widgets/customize_fields.dart';
import 'package:gerencia_loja_pai/blocs/login_bloc.dart';
import '../screens/signup_screen.dart';
import '../validators/fields_validators.dart';

class LoginFields extends StatefulWidget with FieldsValidators {
  //CONSTRUTOR
  LoginFields({super.key});

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  //KEYS
  final formKey = GlobalKey<FormState>();

  //CONTROLLERS
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Variavel Bloc
    final logBloc = BlocProvider.of<LoginBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //esticando o eixo horizontal da coluna, permite que os botões ocupem todo o espaço disponível
          children: [
            //ESTE É O CAMPO DE LOGIN
            CustomizeFields(
              controller: userCtrl,
              label: "Email",
              keyBoard: TextInputType.emailAddress,
              choice: false,
              prefixIcon: Icon(Icons.person),
              //enviando ao widget personalizado duas streams aos mesmo tempo
              stream: logBloc.outUser,
              habilita: logBloc.outLoading,
            ),
            SizedBox(height: 30),
            //ESTE É O CAMPO DE SENHA
            CustomizeFields(
              controller: passCtrl,
              label: "Senha",
              keyBoard: TextInputType.text,
              choice: true,
              prefixIcon: Icon(Icons.password),
              //enviando ao widget personalizado duas streams aos mesmo tempo
              stream: logBloc.outPass,
              habilita: logBloc.outLoading,
            ),
            SizedBox(
              height: 10,
            ),
            //ESTE É O BOTÃO QUE IRÁ REDIRECIONAR PARA TELA DE CADASTRO
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Não possui conta na loja?"),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignupScreen()));
                },
                child: Text(
                  "Clique aqui",
                  style: TextStyle(color: Colors.purple),
                ),
              )
            ]),
            SizedBox(
              height: 40,
            ),
            //ESTE É O BOTÃO QUE FARÁ O LOGIN
            StreamBuilder(
                stream: logBloc.outLoading,
                builder: (context, snapshot) {
                  return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textStyle: TextStyle(fontSize: 25)),
                  onPressed: () async {
                    //Pegando os valores dos campos e inserindo no controller(da classe bloc) correspondente
                    logBloc.inUser.add(userCtrl.text);
                    logBloc.inPass.add(passCtrl.text);

                    //chamando a função de logar
                    await logBloc.logar(context);
                  },
                  child: (snapshot.data == true
                      ? SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : Text("Logar")));
                }),
                  ],
                ),
      ),
    );
  }
}
