import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_loja_virtual/screens/product/widgets/edit_category_dialog.dart';

import '../product_screen.dart';

class CategoryTile extends StatelessWidget {

  //VARIÁVEIS
  final DocumentSnapshot produto;

  //CONSTRUTOR
  const CategoryTile(this.produto, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          leading: GestureDetector(
            onTap: (){
              showDialog(context: context, builder: (context) => EditCategoryDialog(category: produto));
            },
            child: CircleAvatar( //Este Construtor é aquele que deixa uma imagem no tamanho de como se fosse um ícone
              backgroundImage: NetworkImage(produto.get("icon")),
              backgroundColor: Colors.transparent,
            ),
          ),
          title: Text(
            produto.get("title"),
            style: TextStyle(
              color: Colors.grey.shade800, fontWeight: FontWeight.w500
            ),
          ),
          children: [
            FutureBuilder(
               future: produto.reference.collection("itens").get(),
               builder: (context, dados){
                 if( !dados.hasData ){
                   return Container();
                 }else{
                   return Column(
                     children: dados.data!.docs.map((prd){
                       return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(prd.get("images")[0]),
                          ),
                         title: Text(prd.get("title")),
                         trailing: Text(
                           "R\$${prd.get("price").toStringAsFixed(2)}"
                         ),
                         onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ProductScreen(
                                      categoryId: prd.id,
                                      product: prd,
                                    )
                                )
                            );
                         },
                       );
                     }).toList()..add(// este é o botão de adicionar um produto
                       ListTile(
                         leading: CircleAvatar(
                           backgroundColor: Colors.transparent,
                           child: Icon(Icons.add, color: Colors.pinkAccent,),
                         ),
                         title: Text("Adicionar"),
                         onTap: (){
                           Navigator.of(context).push(
                               MaterialPageRoute(builder: (context) => ProductScreen(categoryId: dados.toString(),)
                               )
                           );
                         },
                       )
                     ),
                   );
                 }
               }
            )
          ],
        ),
      ),
    );
  }
}
