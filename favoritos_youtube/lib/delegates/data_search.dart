import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate<String>{

  //Esta função é responsável por mostrar o botão/ícone que ficará no lado direito do campo quando estiver digitando;(por padrão será o ícone de limpar)
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
         onPressed: (){
           query = "";
         },
         icon: Icon(Icons.clear)
      )
    ];
  }

  //Esta função retornará um Widget, o qual será um botão de voltar para tela principal;(neste caso será um botão animado)
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      //Esta função anônima que está no botão, fará com que retorne a tela principal
      onPressed: (){
        close(context, "");
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation
      )
    );
  }


  //Esta função é acionada quando o botão de pesquisar do teclado for clicado;
  //Quando clicado, retornará para tela principal com o resultado da pesquisa feita
  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, query));

    return Container();
  }

  //Esta função irá mostrar as sugestões que foram pesquisadas toda vez que for digitado
  @override
  Widget buildSuggestions(BuildContext context) {
    //Se o campo estiver vazio, então retornará um Container() em branco
    if( query.isEmpty ){
      return Container();
    }else{
      //Se o campo estiver qualquer valor digitado, então retornará um FutureBuilder
      return FutureBuilder(
        future: suggestions(query), //o future é a fonte de onde está vindo as informações
        builder: (context, snapshot){ //o builder é onde mostrará o Widget com as informações vindas do future
          if( !snapshot.hasData ){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            //Aqui está sendo retornado um ListView.Builder a fim de cada item(resultado) seja apresentado um abaixo do outro
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(snapshot.data![index]),
                  leading: Icon(Icons.play_arrow),
                  onTap: (){
                    close(context, {"dado": snapshot.data![index], "result": "teste"}.toString() );
                  },
                );
              }
            );
          }
        }
      );
    }
  }

  //Esta função está fazendo a requisição na API e retornando o valor do seu corpo
  Future<List> suggestions(String search) async {
    http.Response response = await http.get(Uri.parse("http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"));

    if( response.statusCode == 200 ){
      //Este código está retornando apenas o índice da lista que contém o título da pesquisa
      return jsonDecode(response.body)[1].map((v){
        return v[0];
      }).toList();

    }else{
      throw Exception("Failed to load suggestions");
    }

  }
  
}