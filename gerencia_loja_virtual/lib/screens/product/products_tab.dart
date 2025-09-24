import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'widgets/category_tile.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab>  with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("products").get(),
      builder: (context, dados){
        if( !dados.hasData ){
          return Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),),
          );
        }else{
          return ListView(
            children: dados.data!.docs.map((prd){
              return CategoryTile(prd);
            }).toList(),
          );
        }
      }
    );
  }

  @override
  bool get wantKeepAlive => true; //Este método mantém a tela ativa, ou seja, quando sair da tela e volta esta ficará com os dados ativos e não vai ficar carregando toda vez que entrar nela
}
