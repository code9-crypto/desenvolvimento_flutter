import 'dart:io';
import 'package:chat/classes/text_composer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'chat_message.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  //***VARIÁVEIS****
  Map<String, dynamic> data = {};
  final GoogleSignIn googleSignIn = GoogleSignIn(); //variável para fazer login no google
  User? _currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Iniciando o aplicativo e já pegando o usuário logado no google
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user){
      setState(() {
        _currentUser = user;
      });
    });
  }

  void pegaDados() async {
    List<Map> dados = [];
    QuerySnapshot query = await FirebaseFirestore.instance.collection("messages").get();
    query.docs.forEach((d){
      dados.add(d.data() as Map);
    });
    for(Map m in dados){
      print(m['senderName']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          _currentUser != null ? IconButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
                googleSignIn.signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Você saiu com sucesso"),
                      duration: Duration(seconds: 3),
                    )
                );
              },
              icon: Icon(Icons.exit_to_app),
          ) : Container(),
        ],
        title: Text(
          _currentUser != null ? "Olá, ${_currentUser!.displayName}" : "Chat App",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      //Aqui estou chamando o construtor nomeado que recebe por parâmetro uma função(que recebe por parâmetro uma string e um file)
      //OBS.: e esta função vem com os parâmetros da classe filha(text_composer.dart)
      //E dentro da função do construtor, estou chamando outra função que irá enviar os dados(que vieram da outra classe - text-composer.dart) ao firebase
      body: Column(
        children: [
          //Aqui este construtor Expanded, vai expandir a lista de mensagens até o campo de texto(que está sendo chamado por meio do construtor de outra classe)
          Expanded(
            //Este StreamBuilder, vai reconstruir a lista de mensagens em tempo real com o banco de dados
            child: StreamBuilder(
                //Aqui neste stream está acessando os dados em cima da coleção descrita
                stream: FirebaseFirestore.instance.collection("messages").orderBy('time').snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      //Estou pegando os dados do banco de dados e armazenando numa lista do tipo DocumentsSnapshots
                      List<DocumentSnapshot> documents = snapshot.data!.docs.reversed.toList();
                      //Aqui está sendo construído a listView
                      return ListView.builder(
                          itemCount: documents.length,
                          reverse: true,
                          //Este itemBuilder, está construindo cada item da lista com o texto, estilo....
                          itemBuilder: (context, index) {
                            //Este construtor é responsável por apresentar os dados na tela, tanto imagem como texto
                            //OBS.: deve ser feito o cast para que seja possível passar os dados para a outra classe
                           return ChatMessage(
                               documents[index].data() as Map<String, dynamic>,
                                _currentUser != null ? documents[index].get('uid') == _currentUser!.uid : false
                           );
                          });
                  }
                }),
          ),
          //Chamando o construtor da outra classe, a qual está exibindo o campo de texto junto com os botões de enviar mensagem e tirar foto
          TextComposer.func(saveMessage),
        ],
      ),
    );
  }

  //***FUNÇÕES***

  //ESTA FUNÇÃO ESTÁ FAZENDO LOGIN NO GOOGLE PARA DEPOIS ACESSAR O BANCO DE DADOS NO FIREBASE
  Future<User?> _getUser() async {
    //Verificando se o usuário está logado ou não
    //Caso não, então vai ser nulo e o programa vai pedir para se logar
    //Caso sim, então vai continuar sem pedir para se logar
    if( _currentUser != null ){
      return _currentUser;
    }else {
      try {
        final GoogleSignInAccount? googleSignInAccount = await googleSignIn
            .signIn(); //fazendo login no google
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!
            .authentication; //desta forma eu posso pegar o ID do usuário e o token

        //pegando as credencias do usuário logado no google e armazenando-as na variavel credential
        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken
        );

        final UserCredential authResult = await FirebaseAuth.instance
            .signInWithCredential(
            credential); //fazendo o login no banco de dados com as credenciais do google

        final User? user = authResult
            .user; //acessando o firebase com este user que foi autenticado como google

      } catch (error) {
        return null;
      }
    }
    return null;
  }

  //ESTA FUNÇÃO ESTÁ ENVIANDO O TEXTO PARA O BANCO DE DADOS LÁ NO FIREBASE
  //OBS.: da forma que foi declarada a função no construtor da classe filha, deve ser o mesmo declarado aqui na classe pai
  void saveMessage({String? text, File? imgFile}) async {

    //pegando o usuário que foi logado no google por meio da função _getUser()
    final User? user = await _getUser();

    if( user == null || user.displayName!.isEmpty ){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Não foi possível fazer o login. Tente novamente"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
        )
      );
    }

    data = {
      "uid" : user!.uid,
      "senderName" : user.displayName,
      "senderPhotoUrl" : user.photoURL,
      "time" : Timestamp.now()
    };

    if (imgFile != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task; //não é necessário aplicar o onComplete
      String url = await taskSnapshot.ref.getDownloadURL(); //pegando a URL de download da imagem
      data['imgUrl'] = url;
    }

    if (text != null) {
      data['text'] = text;
    }

    FirebaseFirestore.instance.collection("messages").add(data);
  }
}
