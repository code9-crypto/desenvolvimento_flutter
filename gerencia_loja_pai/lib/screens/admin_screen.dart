import 'package:flutter/material.dart';
import 'package:gerencia_loja_pai/blocs/login_bloc.dart';
import 'package:gerencia_loja_pai/screens/home_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = LoginBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Gerência"),
        actions: [
          IconButton(
            onPressed: (){
              loginBloc.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen())
              );
            },
            icon: Icon(Icons.exit_to_app_rounded)
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("Tela da gerencia"),
      ),
    );
  }
}

