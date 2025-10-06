import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_loja_virtual/screens/product/blocs/products_bloc.dart';
import 'package:gerencia_loja_virtual/screens/product/widgets/images_widget.dart';

class ProductScreen extends StatelessWidget {

  //VARIAVEIS E BLOC
  final String categoryId;
  final DocumentSnapshot? product; //deste jeito é possível passar um valor sem que seja obrigatória sua passagem no construtor
  late ProductsBloc prodBloc;
  final formKey = GlobalKey<FormState>(); //será usado para fazer as validações dos campos

  //CONSTRUTOR
  ProductScreen({super.key,  required this.categoryId, this.product });

  @override
  Widget build(BuildContext context) {

    //constantes das widgets
    final fieldStyle = TextStyle(
      color: Colors.white,
      fontSize: 16
    );

    //bloc
    prodBloc = ProductsBloc(context, categoryId: categoryId, product: product);

    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.grey.shade800,
        elevation: 0,
        title: Text(
          "Criar Produto",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.remove)
          ),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.save)
          )
        ],
      ),
      body: Form(
        key: formKey, //esta key é para fazer a validação
        child: StreamBuilder(
          stream: prodBloc.outData,
          builder: (context, snapshot) {
            if( !snapshot.hasData )  return Container();
            return SafeArea(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Text(
                    "Imagens",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  ImagesWidget(
                    context: context,
                    initialValue: snapshot.data["images"],
                    onSaved: (l){},
                    validator: (l){
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: snapshot.data["title"],
                    style: fieldStyle, // esta é a parte do estilo do texto que será digitado dentro do campo
                    decoration: buildDecoration("Título"),
                    onSaved: (saved){
              
                    },
                    validator: (valid){
                      return null;
                    
              
                    },
                  ),
                  TextFormField(
                    initialValue: snapshot.data["description"],
                    style: fieldStyle, //
                    decoration: buildDecoration("Descrição"),
                    maxLines: 6,
                    onSaved: (saved){
              
                    },
                    validator: (valid){
                      return null;
                    
              
                    },
                  ),
                  TextFormField(
                    initialValue: snapshot.data["price"].toStringAsFixed(2),
                    style: fieldStyle, //
                    decoration: buildDecoration("Preço"),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onSaved: (saved){
              
                    },
                    validator: (valid){
                      return null;
                    
              
                    },
                  )
                ],
              ),
            );
          }
        )
      ),
    );
  }

  InputDecoration buildDecoration(String label){
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey)
    );
  }
}
