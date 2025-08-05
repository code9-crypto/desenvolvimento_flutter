import 'package:favoritos_youtube/blocks/favorite_bloc.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoTile extends StatelessWidget {
  late final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        video.title,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        video.channel,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                stream: bloc.outFav,
                //initialData: {},quando a gente trabalhar com Map no StreamBuilder, o valor padrão inicial é chaves vazias
                builder: (context, snapshot){
                  if( snapshot.hasData ){
                    return IconButton(
                      onPressed: () {
                        bloc.toggleFavorite(video);
                      },
                      icon: Icon(
                        snapshot.data!.containsKey(video.id) ? Icons.star : Icons.star_border,
                        color: Colors.white,
                        size: 30,
                      ),
                    );
                  }else{
                    return CircularProgressIndicator();
                  }
                }
              )
            ],
          )
        ],
      ),
    );
  }
}
