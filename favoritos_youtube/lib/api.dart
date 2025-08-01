import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/video.dart';

//Esta constante é a api que nos permitirá fazer as buscas na API do youtube
//const API_KEY = "AIzaSyAc-iV27JA_br7RHMm8SWKOxoz0PNVjlw8"; projeto do google flutteryoutube
const API_KEY = "AIzaSyBK-gQkxrpTIpVJlZ5m1_xbT9uyV9Q3Knc"; //projeto Projeto2

class Api{
  late String _search;
  late String _nextToken;

  //Esta função está fazendo busca pelo video
  Future<List<Video>> search(String seek) async {

    _search = seek;

    http.Response response = await http.get(Uri.parse("https://www.googleapis.com/youtube/v3/search?part=snippet&q=$seek&type=video&key=$API_KEY&maxResults=10"));

    return decode(response);
  }

  //Esta função fará a busca dos próximos 10 itens
  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(Uri.parse("https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"));

    return decode(response);
  }

  //Esta função está fazendo ao conversão de json para um objeto do tipo customizado(Video)
  List<Video> decode(http.Response resp){

    if( resp.statusCode == 200 ){

      var decoded = json.decode(resp.body);//aqui pegou o parâmetro do tipo http.Response, decodificando e armazenando o resultado na variável decoded

      _nextToken = decoded["nextPageToken"];

      //Aqui está pegando cada item da lista de videos(armazenada na variavel decoded['item']), transformando num objeto video e devolvendo(este objeto) para uma lista de videos
      List<Video> videos = decoded["items"].map<Video>((map) => Video.fromJson(map)).toList();

      return videos;

    }else if( resp.statusCode == 403 ) {
      throw Exception("Excced cota requests");
    }else{
      throw Exception("Failed to load videos");
    }

  }

}