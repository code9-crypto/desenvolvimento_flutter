import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_loja_pai/blocs/login_bloc.dart';
import 'package:gerencia_loja_pai/screens/home_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        theme: ThemeData(
          //Aqui é a configuração padrão da appBar para todas as telas
            appBarTheme: AppBarTheme(
              centerTitle: true,
              foregroundColor: Colors.white,
              backgroundColor: Colors.cyan,
            )
        ),
      ),
    );
  }
}