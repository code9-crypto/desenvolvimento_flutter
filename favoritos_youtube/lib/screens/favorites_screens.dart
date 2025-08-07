import 'package:favoritos_youtube/blocks/favorite_bloc.dart';
import 'package:favoritos_youtube/screens/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/video.dart';

class FavoritesScreens extends StatelessWidget {
  const FavoritesScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos", style: TextStyle(color: Colors.white70),),
        centerTitle: true,
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(
          color: Colors.white70
        ),
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
         stream: bloc.outFav,
         initialData: {},
         builder: (context, snapshot){
           return ListView(
             //Aqui está criando todos os itens da lista de forma programática
             children: snapshot.data!.values.map((v){
               return InkWell(
                 onLongPress: (){
                   bloc.toggleFavorite(v);
                 },
                 onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoPlayer(video: v))
                    );
                 },
                 child: Row(
                   children: [
                     Container(
                       width: 100,
                       height: 50,
                       child: Image.network(v.thumb),
                     ),
                     Expanded(
                        child: Text(
                          v.title, style: TextStyle(color: Colors.white70),
                          maxLines: 2,
                        )
                     )
                   ],
                 ),
               );
             }).toList(),
           );
         },
      ),
    );
  }
}
