import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'models/video.dart';

const API_KEY = "AIzaSyAc-iV27JA_br7RHMm8SWKOxoz0PNVjlw8"; //esta constante é a api que nos permitirá fazer as buscas na API do youtube

class Api{

  //Esta função está fazendo busca pelo video
  search(String seek) async {
    http.Response response = await http.get(Uri.parse("https://www.googleapis.com/youtube/v3/search?part=snippet&q=$seek&type=video&key=$API_KEY&maxResults=10"));

  }

  //Esta função está fazendo ao conversão de json para um objeto do tipo customizado(Video)
  List<Video> decode(http.Response resp){

    if( resp.statusCode == 200 ){

      var decoded = json.decode(resp.body);//aqui pegou o parâmetro do tipo http.Response, decodificando e armazenando o resultado na variável decoded

      //Aqui está pegando cada item da lista de videos(armazenada na variavel decoded['item']), transformando num objeto video e devolvendo(este objeto) para uma lista de videos
      List<Video> videos = decoded["items"].map<Video>((map) => Video.fromJson(map)).toList();

      return videos;

    }else{

      throw Exception("Failed to load videos");

    }

  }

}