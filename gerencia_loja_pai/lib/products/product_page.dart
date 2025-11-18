import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_loja_pai/datas/products_data.dart';
import 'package:gerencia_loja_pai/screens/product_screen.dart';

class ProductPage extends StatelessWidget {
  //VARIAVEIS
  late String produto;

  //CONSTRUTOR
  ProductPage({super.key, required this.produto});
  
  //CONSTANTES
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String prodDoc = produto.toLowerCase();

    return Scaffold(
      appBar: AppBar(
        title: Text(produto == "Utensilios" ? "$produto" : "Moda $produto"),
      ),
      body: FutureBuilder(
        future: firestore.collection("produtos").doc(prodDoc).collection("itens").get(),
        builder: (context, snapshot){
          if( !snapshot.hasData ){
            return Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.cyan),),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
                //constante para comando snapshot
                DocumentSnapshot produto = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          //convertendo os dados do banco para a classe ProductData
                          ProductData prd = ProductData(produto);

                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ProductScreen(produto: prd))
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Image.network(
                                corrigirLinkGoogleDrive(snapshot.data!.docs[index].get('image')),
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                              flex: 1,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Produto: ${snapshot.data!.docs[index].get("nome")}",
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "Preço: R\$ 00,00",
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "Quantidade: 2 unidades",
                                  style: TextStyle(
                                      fontSize: 20
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 50,),
                      Divider(
                        color: Colors.grey.shade500,
                      )
                    ],
                  ),
                );
              }
            );
          }
        }
      ),
    );
  }

  //FUNÇÕES

  //Esta função pega o link do google drive e transforma para um link válido de modo que a imagem possa ser exibida na listview
  String corrigirLinkGoogleDrive(String urlOriginal) {
    final regex = RegExp(r'/d/([a-zA-Z0-9_-]+)');
    final match = regex.firstMatch(urlOriginal);
    if (match != null) {
      final id = match.group(1);
      return 'https://drive.google.com/uc?export=view&id=$id';
    }
    return urlOriginal; // se não bater o padrão, devolve o original
  }
}
