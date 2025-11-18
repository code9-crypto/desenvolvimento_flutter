import 'package:favoritos_youtube/api.dart';
import 'package:favoritos_youtube/blocks/favorite_bloc.dart';
import 'package:favoritos_youtube/blocks/video_bloc.dart';
import 'package:favoritos_youtube/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //PARA QUE TODO O APP POSSA SURTIR O EFEITO DAS INFORMAÇÕES QUE FORAM MODIFICADAS, OBRIGATORIAMENTE DEVE SER USADO O BLOCPROVIDER
    //CASO SEJA USADO O BLOC DE FORMA ESTÁTICA, AS INFORMAÇÕES NO DECORRER DO APP NÃO RECEBERÁ A MODIFICAÇÃO DOS VALORES E CONSEQUENTEMENTE A STREAMBUILDER NÃO SERÁ ALTERADA
    return BlocProvider( //Este BlocProvider permite acessar(de qualquer lugar do código) a classe VideosBloc
      create: (_) => VideoBlock(context),
      child: BlocProvider(
        create: (_) => FavoriteBloc(context),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Home(),
        ),
      )
    );
  }
}
