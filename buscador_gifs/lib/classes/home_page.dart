import 'dart:convert';
import 'package:buscador_gifs/classes/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //**** VARIAVEIS ****
  String _search = "";
  int _offSet = 0;


  //Iniciando o aplicativo já chamando a função de requisitar os dados na API
  /*@override
  void initState() {
    super.initState();
    _getGifs().then((map){
      print(map);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          //Cor de fundo do app
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            //No title tem uma imagem que foi pega direto da internet com seu link
            title: Image.network("https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onSubmitted: (text){//Este método vai ser executado quando clicar no botão de enter do teclado do celular. Por padrão ele recebe um parâmetro, o qual é o texto digitado no campo
                    setState(() {
                      _search = text;
                      //Resetando o offset para 0 quando for feito uma nova pesquisa
                      _offSet = 0;
                    });
                  },
                  //Aqui é a decoração do label do campo0
                  decoration: InputDecoration(
                    labelText: "Pesquise aqui",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder()
                  ),
                  //Este style é a cor do texto quando for digitado
                  style: TextStyle(
                    color: Colors.white, fontSize: 18.0,
                  ),
                  //alinhamento do texto
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                  //Como os dados virão do futuro, então devemos colocar os dados dentro de um FutureBuilder
                  child: FutureBuilder(
                      //este parâmetro future é o que recebe a função que fará a requisição na API
                      future: _getGifs(),
                      //Este parâmetro builder é o que irá desenhar o layout na tela depois que os dados forem carregados
                      builder: (context, snapshot){
                        switch(snapshot.connectionState){
                          //Caso a conexão esteja em espera(waiting) ou não tenha conexão(none) então será retornar um Container() mostrando este indicativo
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            //Será exibido um Container com uma imagem circular da cor branca rodando no meio da tela
                            return Container(
                              alignment: Alignment.center,
                              width: 200.0,
                              height: 200.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 5.0,
                              ),
                            );
                          default:
                            if(snapshot.hasError){
                              return Container();
                            }else{
                              return _createGifTable(context, snapshot);
                            }
                        }
                      }
                  ),
              ),
            ],
          ),
        )
    );
  }

  //*** FUNÇÕES ***

  //esta função retorna a quantidade de itens da lista
  int _getCount(List data){
    if( _search.isEmpty ){
      return data.length;
    }else{
      return data.length + 1;
    }
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot){
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        //Este item gridDelegate é como os itens será exibidos na tela
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //Este crossAxisCount é quantos itens terão em cada linha
            crossAxisCount: 2,
            crossAxisSpacing: 10.0, // este é o espaço entre os itens na horizontal
            mainAxisSpacing: 10.0,// este é o espaço entre os itens na vertical
        ),
        itemCount: _getCount(snapshot.data["data"]), //quantos itens vão aparecer na tela
        itemBuilder: (content, index){
          if( _search.isEmpty || index < snapshot.data["data"].length ) {
            //Este construtor permite clicar na imagem e mostrá-la em outra tela
            return GestureDetector(
              //Quando clicar e segurar, será exibido a tela de compartilhar
              onLongPress: (){
                SharePlus.instance.share(
                    ShareParams(
                        text: snapshot.data["data"][index]["images"]["fixed_height"]["url"]
                    )
                );
              },
              onTap: (){
                //Este navigator é o responsável de fazer a mundaça das telas de acordo com a rota definida
                Navigator.push(
                    context,
                    //Este MaterialPageRoute é que faz a transição de mudança de tela
                    MaterialPageRoute(
                        builder: (context) => GifPage(snapshot.data["data"][index])
                    )
                );
              },
              //Este FadeInImage é a forma de fazer as imagens aparecerem mais suavemente
              child: FadeInImage.memoryNetwork(
                  //Neste atributo placeholder é usado uma imagem transparente(usando o pacote transparent_image)
                  placeholder: kTransparentImage,
                  //neste atributo image é a url recupera da API
                  image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
                  height: 300.0,
                  fit: BoxFit.cover,
              ),
            );
          }else{
            return Container(
              child: GestureDetector(
                child: Column(
                  //Alinhando o botão de carregar mais no centro
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Icon(Icons.add, color: Colors.white, size: 70.0,),
                    Text("Carregar mais...", style: TextStyle(color: Colors.white, fontSize: 22.0),)

                  ]
                ),
                onTap: (){
                  setState(() {
                    _offSet += 23;
                  });
                },
              ),
            );
          }
        }
    );
  }

  //Esta função fará requisição na API
  Future<Map> _getGifs() async{
    http.Response response;
    if( _search.isEmpty ){
      //Fazendo a requisição na API e atribuindo seu resultado a variável response(que é do tipo http.Response)
      response = await http.get(Uri.parse("https://api.giphy.com/v1/gifs/trending?api_key=xsu6TlrN3uBxtJbloCuYgAinQTS38iR2&limit=25&offset=0&rating=g&bundle=messaging_non_clips"));
    }else{
      response = await http.get(Uri.parse("https://api.giphy.com/v1/gifs/search?api_key=xsu6TlrN3uBxtJbloCuYgAinQTS38iR2&q=$_search&limit=23&offset=$_offSet&rating=g&lang=pt&bundle=messaging_non_clips"));
    }

    return json.decode(response.body);
  }
}
