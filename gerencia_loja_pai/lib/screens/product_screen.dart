import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_loja_pai/blocs/login_bloc.dart';
import 'package:gerencia_loja_pai/datas/products_data.dart';

class ProductScreen extends StatelessWidget {
  //VARIAVEIS
  late ProductData produto;

  ProductScreen({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(produto.nome),
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
                "Preço: R\$ 00,00",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30,),
              Text(
                "Quantidade: 2 unidades",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: (){},
                child: StreamBuilder<bool>(
                  stream: loginBloc.outLoggedIn,
                  initialData: false,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData && snapshot.data == true ? "Reservar" : "Logar no sistema",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),
                    );
                  }
                )
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
