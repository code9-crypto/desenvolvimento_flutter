import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_loja_virtual/screens/product/blocs/products_bloc.dart';
import 'package:gerencia_loja_virtual/screens/product/validators/product_validator.dart';
import 'package:gerencia_loja_virtual/screens/product/widgets/images_widget.dart';
import 'package:gerencia_loja_virtual/screens/product/widgets/products_size.dart';

class ProductScreen extends StatelessWidget with ProductValidator{

  //VARIAVEIS E BLOC
  final String categoryId;
  final DocumentSnapshot? product; //deste jeito é possível passar um valor sem que seja obrigatória sua passagem no construtor
  late ProductsBloc prodBloc;
  final formKey = GlobalKey<FormState>(); //será usado para fazer as validações dos campos
  final scafKey = GlobalKey<ScaffoldState>();


  //CONSTRUTOR
  ProductScreen({super.key,  required this.categoryId, this.product });

  @override
  Widget build(BuildContext context) {

    //constantes das widgets
    final fieldStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    //bloc
    prodBloc = ProductsBloc(context, categoryId: categoryId, product: product);

    return Scaffold(
      key: scafKey,
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.grey.shade800,
        elevation: 0,
        title: StreamBuilder(
          stream: prodBloc.outCreated,
          initialData: false,
          builder: (context, snapshot) {
            return Text(
              snapshot.data ? "Editar produto" : "Criar produto",
              style: TextStyle(
                color: Colors.white
              ),
            );
          }
        ),
        actions: [
          StreamBuilder(
            stream: prodBloc.outCreated,
            initialData: false,
            builder: (context, snapshot){
              if( snapshot.data ){
                return StreamBuilder(
                  stream: prodBloc.outLoading,
                  initialData: false,
                  builder: (context, snapshot) {
                    return IconButton(
                      onPressed: snapshot.data ? null : (){
                        prodBloc.deleteProduct();
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.remove, color: Colors.white,)
                    );
                  }
                );
              } else{
                return Container();
              }
            }
          )
          ,
          StreamBuilder(
            stream: prodBloc.outLoading,
            initialData: false,
            builder: (context, snapshot) {
              return IconButton(
                  onPressed: snapshot.data ? null : saveProduct,
                  icon: Icon(Icons.save)
              );
            }
          )
        ],
      ),
      body: Stack(
        children: [
          Form(
            key: formKey, //esta key é para fazer a validação
            child: StreamBuilder(
              stream: prodBloc.outData,
              builder: (context, snapshot) {
                if( !snapshot.hasData )  return Container();
                return ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    Text(
                      "Imagens",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    ImagesWidget(
                      context: context,
                      initialValue: snapshot.data["images"],
                      onSaved: prodBloc.saveImages, //aqui está passando a função, por isso não está com parenteses; Se passasse com parênteses significa que está querendo obter o resultado da função
                      validator: validateImages //aqui está passando a função, por isso não está com parenteses; Se passasse com parênteses significa que está querendo obter o resultado da função
                    ),
                    TextFormField(
                      initialValue: snapshot.data["title"],
                      style: fieldStyle, // esta é a parte do estilo do texto que será digitado dentro do campo
                      decoration: buildDecoration("Título"),
                      onSaved: prodBloc.saveTitle, //aqui está passando a função, por isso não está com parenteses; Se passasse com parênteses significa que está querendo obter o resultado da função
                      validator: validateTitle, //aqui está passando a função, por isso não está com parenteses; Se passasse com parênteses significa que está querendo obter o resultado da função
                    ),
                    TextFormField(
                      initialValue: snapshot.data["description"],
                      style: fieldStyle, //
                      decoration: buildDecoration("Descrição"),
                      maxLines: 6,
                      onSaved: prodBloc.saveDescription,//aqui está passando a função, por isso não está com parenteses; Se passasse com parênteses significa que está querendo obter o resultado da função
                      validator: validateDescription//aqui está passando a função, por isso não está com parenteses; Se passasse com parênteses significa que está querendo obter o resultado da função
                    ),
                    TextFormField(
                      initialValue: snapshot.data["price"]?.toStringAsFixed(2),
                      style: fieldStyle, //
                      decoration: buildDecoration("Preço"),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onSaved: prodBloc.savePrice, //aqui está passando a função, por isso não está com parenteses; Se passasse com parênteses significa que está querendo obter o resultado da função
                      validator: validatePrice, //aqui está passando a função, por isso não está com parenteses; Se passasse com parênteses significa que está querendo obter o resultado da função
                    ),
                    SizedBox(height: 16,),
                    Text(
                      "Tamanhos",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12
                      ),
                    ),
                    ProductsSize(
                      initialValue: snapshot.data["sizes"],
                      onSaved: (s){},
                      validator: (v){}
                    )
                  ],
                );
              }
            )
          ),
          //Esta parte aqui será usado para deixar a tela com tom de escuro enquanto os dados são salvos
          StreamBuilder(
             stream: prodBloc.outLoading,
             initialData: false,
             builder: (context, snapshot){
                return IgnorePointer(
                  ignoring: !snapshot.data,
                  child: Container(
                    color: snapshot.data ? Colors.black26 : Colors.transparent,
                  ),
                );
             }
          )
        ],
      ),
    );
  }

  //Este é uma função que retorna uma InputDecoration padrão para todos
  InputDecoration buildDecoration(String label){
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey),
      errorStyle: TextStyle(color: Colors.red),
    );
  }

  //Função será usada para salvar os dados
  void saveProduct() async {
    if(formKey.currentState!.validate()){//aqui está pegando o estado do voluntário atual para fazer a verificação de validação. Este método aciona todos os parâmetros validator
      formKey.currentState!.save(); //esta função save() irá acionar a função onSaved de todos os TextFormField

      ScaffoldMessenger.of(scafKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(
            "Salvando produto...",
            style: TextStyle(
              color: Colors.white
            ),
          ),
          duration: Duration(minutes: 1),
          backgroundColor: Colors.pinkAccent,
        )
      );

      bool success = await prodBloc.savePrdBanco(); //esta variavel está recebendo o resultado da função

      ScaffoldMessenger.of(scafKey.currentContext!).removeCurrentSnackBar(); //aqui está removendo a snackbar anterior para depois mostrar a snackbar seguinte

      ScaffoldMessenger.of(scafKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(
            success ? "Produto salvo" : "Erro ao salvar produto",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          backgroundColor: Colors.pinkAccent,
        )
      );
    }
  }
}
