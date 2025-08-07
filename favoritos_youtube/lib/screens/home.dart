import 'package:favoritos_youtube/blocks/favorite_bloc.dart';
import 'package:favoritos_youtube/blocks/video_bloc.dart';
import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:favoritos_youtube/screens/favorites_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/video.dart';
import '../tiles/video_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideoBlock>(context); //é possível criar esta variável para classe apenas dentro do build devido ao parâmetro context
    final blocFav = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        //Colocando uma imagem na barra de título da appBar
        title: Container(
          height: 35,
          child: Image.asset("assets/logo_youtube.png"),
        ),
        elevation: 0, //este parâmetro quando setado para 0, não deixa uma sombra que fica abaixo da appBar
        //Botões da AppBar(por padrão fica alinhada do lado direito)
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              initialData: {}, //quando a gente trabalhar com Map no StreamBuilder, o valor padrão inicial é chaves vazias
              stream: blocFav.outFav,
              builder: (context, snapshot){
                if( snapshot.hasData ){
                  return Text("${snapshot.data!.length}", style: TextStyle(color: Colors.white),);
                }else{
                  return Container();
                }
              }
            )
          ),
          IconButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreens())
              );
            },
            icon: Icon(Icons.star, color: Colors.white, size: 30, )
          ),
          IconButton(
              onPressed: () async{
                //este é o comando que mostrará a tela de pesquisa apontando para a classe DataSearch
                //E seu resultado está sendo armazenado numa variavel para depois ser inserido no StreamController de entrada
                String? result = await showSearch(context: context, delegate: DataSearch());

                //Enviandos dados para API
                if( result != null ){
                  bloc.inSearch.add(result);
                }
              },
              icon: Icon(Icons.search, color: Colors.white, size: 30, )
          ),
        ],
      ),
      //Aqui é a parte onde será exibido todos os resultados da pesquisa feita
      body: StreamBuilder(
        stream: bloc.outVideos,
        //initialData: [],
        builder: (context, snapshot){
          if( snapshot.hasData ){
            return ListView.builder(
                itemCount: snapshot.data.length +1 ,
                itemBuilder: (context, index){
                  if( index < snapshot.data.length ){
                    return VideoTile(snapshot.data[index]);
                  } else if( index > 1 ){
                    bloc.inSearch.add("");
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red),),
                    );
                  } else {
                    return Container();
                  }
                }
            );
          } else{
            return Container();
          }
        }
      ),
    );
  }
}
