import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandos_linux/data/comands_data.dart';
import 'package:flutter/material.dart';

//ESTA CLASSE ESTÁ EXIBINDO O CONTEÚDO QUE FOI OBTIDO DO BANCO
class Comand extends StatelessWidget {
  //***VARIÁVEIS***
  ComandsData dataComands;

  //***CONSTRUTORES***
  Comand(this.dataComands);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dataComands.titulo,
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("comandos")
            .doc(dataComands.id)
            .collection("itens")
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        Text(
                          snapshot.data!.docs[index].get("title"),
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          snapshot.data!.docs[index].get("body"),
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600),
                        ),
                        Divider()
                      ],
                    ),
                  ),
                );
              });
          }
        }),
    );
  }
}
