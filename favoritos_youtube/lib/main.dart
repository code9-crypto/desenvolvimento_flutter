import 'package:favoritos_youtube/api.dart';
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
    return BlocProvider( //Este BlocProvider permite acessar(de qualquer lugar do código) a classe VideosBloc
      create: (_) => VideoBlock(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
