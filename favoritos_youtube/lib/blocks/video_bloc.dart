import 'dart:async';
import 'dart:ffi';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:favoritos_youtube/api.dart';
import '../models/video.dart';

class VideoBlock extends BlocBase{

  late Api api;
  late List<Video> videos;

  //STREAMS

  //Esta stream é para a entrada dos dados
  final StreamController<String> _searchController = StreamController<String>(); //esta é a variável da StreamController que receberá a entrada dos dados
  Sink get inSearch => _searchController.sink; //esta é a função inSearch que receberá a entrada dos dados e essa entrada sink será acessada pela função inSearch

  //Esta stream é para a saída dos dados
  final StreamController _videosController = StreamController(); //esta é a variável do StreamController que enviará a saída dos dados
  Stream get outVideos => _videosController.stream; // este é a função outVideos que enviaráda os dados e esse envio stream será enviado por meio da função outVideos


  VideoBlock(super._state){
    api = Api();

    //Enviando a informação pesquisada(que está dentro do searchController) e enviando a API
    _searchController.stream.listen(_search as void Function(String event)?); //aqui dentro vai uma função que será chamada toda vez que o _searchController receber um dado
  }

  void _search(String search) async {
    print(search);
    videos = await api.search(search);
    //_videosController.sink.add(videos);

    print(videos);
  }

  /*@override
  void dispose () {

  }*/

}