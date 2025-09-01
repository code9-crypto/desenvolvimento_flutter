import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/video.dart';

class FavoriteBloc extends BlocBase{

  Map<String, Video> favorites = {};
  final _favController = BehaviorSubject<Map<String, Video>>();

  //Funções get do Stream
  Stream<Map<String, Video>> get outFav => _favController.stream;
  Sink get inFav => _favController.sink;

  //Esta função irá colocar o video nos favoritos
  //Se tiver na lista, então irá retirá-lo, caso contrario irá colocá-lo
  //E por fim irá adicionar na entrada do _favController.sink
  void toggleFavorite(Video video){
    if( favorites.containsKey(video.id) ) favorites.remove(video.id);
    else favorites[video.id] = video;

    inFav.add(favorites);

    _saveFav();
  }

  //Salvando o video dos favoritos no dispositivo
  void _saveFav(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("favorites", json.encode(favorites));
    });
  }

  FavoriteBloc(super.state){
    SharedPreferences.getInstance().then((prefs){
      if( prefs.getKeys().contains("favorites") ){
        favorites = json.decode(prefs.getString("favorites")!).map((k, v){
          return MapEntry(k, Video.fromJson(v));
        }).cast<String, Video>();
        _favController.add(favorites);
      }
    });
  }
}