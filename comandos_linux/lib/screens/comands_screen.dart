import 'package:comandos_linux/data/comands_data.dart';
import 'package:comandos_linux/tile/comands_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComandsScreen extends StatelessWidget {
  const ComandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        title: Text("Lista de comandos linux"),
      ),
      //Normalmente sempre no body do Scaffold vai o FutureBuilder
      body: FutureBuilder(
        //Aqui estou pegando os documentos do banco
        future: FirebaseFirestore.instance.collection("comandos").get(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6
                ),
                //aqui está verificando a quantidade de documentos que veio do banco
                itemCount: snapshot.data!.docs.length,
                //Aqui está construindo item por item(um a um) de acordo com index que está sendo passado por parâmetro
                itemBuilder: (context, index){
                  //Aqui está pegando cada item do documento e enviando ao ComandsTile, mas com a configuração do ComandsData
                  return ComandsTile(ComandsData(snapshot.data!.docs[index])); //aqui está fazendo um apontamento para mostrar como vai ficar cada layout
                }
            );
          }
        }
      ),
    );
  }
}
