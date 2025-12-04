import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_loja_pai/blocs/login_bloc.dart';
import 'package:gerencia_loja_pai/datas/products_data.dart';
import 'package:gerencia_loja_pai/mobx/reserve_products.dart';
import 'package:gerencia_loja_pai/screens/cart_screen.dart';
import 'package:gerencia_loja_pai/screens/login_screen.dart';

class ProductScreen extends StatelessWidget {
  //VARIAVEIS
  late ProductData produto;

  ProductScreen({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    ReserveProducts reserve = ReserveProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text(produto.nome),
      ),
      floatingActionButton: StreamBuilder(
        stream: loginBloc.outLoggedIn,
        builder: (context, snapshot) {
          return snapshot.hasData && snapshot.data == true ? FloatingActionButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CartScreen(loginBloc.userID.value.toString()))
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            child: Icon(Icons.shopping_cart, color: Colors.white,),
            backgroundColor: Colors.cyan,
          ) : Container();
        }
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(top: 16.0),
                alignment: Alignment.center,
                width: 500,
                height: 400,
                child: Image.network(
                  corrigirLinkGoogleDrive(corrigirLinkGoogleDrive(produto.imgUrl)),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 50,),
              Text(
                "Preço: R\$ ${produto.price}",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30,),
              StreamBuilder(
                stream: loginBloc.outLoggedIn,
                builder: (context, snapshot) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    onPressed: snapshot.hasData && snapshot.data == true ? (){
                      String userID = loginBloc.userID.value.toString();
                      reserve.reservar(produto, userID, context);
                    } : (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen())
                      );
                    },
                    child: Text(
                      snapshot.hasData && snapshot.data == true ? "Adicionar ao carrinho" : "Logar no sistema",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),
                    )
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  //FUNÇÕES
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
