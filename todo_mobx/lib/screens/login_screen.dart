import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:todomobx/stores/login_store.dart';
import 'package:todomobx/widgets/custom_icon_button.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

import 'list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginStore = LoginStore();
  late ReactionDisposer disposer;


  //Para fazer a alteração de telas, sem que seja dentro do botão, é por meio do método didChangeDependencies
  //E dentro dele usando o autorun( OBS.: este - autorun - sempre será executado pela primeira vez )
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    disposer = reaction(
      (_) => loginStore.loggedIn,
      (login){
        if( login ){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => ListScreen())
          );
        }
      }
    );
  }

  /*@override
  void initState() {
    primaryColor = Theme.of(context).primaryColor;
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //ESTE É O CAMPO DE EMAIL
                  Observer(
                    builder: (_) => CustomTextField(
                      hint: 'E-mail',
                      prefix: Icon(
                        Icons.account_circle,
                        color: primaryColor,
                      ),
                      textInputType: TextInputType.emailAddress,
                      onChanged: loginStore.setEmail,
                      enabled: !loginStore.carregando,
                      ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  //ESTE É O CAMPO DE SENHA
                  Observer(
                    builder: (context){
                      return CustomTextField(
                        hint: 'Senha',
                        prefix: Icon(
                          Icons.lock,
                          color: primaryColor,
                        ),
                        obscure: !loginStore.visivel,
                        onChanged: loginStore.setPass,
                        enabled: !loginStore.carregando,
                        suffix: CustomIconButton(
                          radius: 32,
                          iconData: !loginStore.isVisible ? Icons.visibility : Icons.visibility_off,
                          onTap: loginStore.setVisivel,
                        ),
                      );
                    }
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Observer(
                    builder: (context){
                      return SizedBox(
                        height: 44,
                        width: 100,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            backgroundColor:
                            MaterialStateProperty.resolveWith<Color>((states) {
                              if (states.contains(MaterialState.disabled)) {
                                return primaryColor.withAlpha(100);
                              } else {
                                return primaryColor;
                              }
                            }),
                            textStyle: MaterialStateProperty.all(
                              TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: loginStore.loginPressed, //tirando essa lógica do botão e deixando na classe login_store.dart
                          /*loginStore.isFormValid ? (){
                            Navigator.of(context).push(
                              MaterialPageRoute((context) => ListScreen())
                            )
                          } : null*/
                          child: loginStore.carregando ? SizedBox(height: 30, width: 30, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white), ),)  :
                          Text('Login', style: TextStyle(color: Colors.white)),
                        ),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Esse dispose faz o despejo dos recursos que não estão sendo usado para evitar uma sobrecarga do uso de hardware
  @override
  void dispose() {
    disposer;
    super.dispose();
  }
}