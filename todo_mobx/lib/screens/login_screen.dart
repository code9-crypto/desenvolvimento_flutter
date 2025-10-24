import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
                  CustomTextField(
                    hint: 'E-mail',
                    prefix: Icon(
                      Icons.account_circle,
                      color: primaryColor,
                    ),
                    textInputType: TextInputType.emailAddress,
                    onChanged: loginStore.setEmail,
                    enabled: true,
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
                        obscure: !loginStore.isVisible,
                        onChanged: loginStore.setPass,
                        enabled: true,
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
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onPressed: loginStore.isFormValid ? (){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ListScreen()));
                          } : null,
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
}