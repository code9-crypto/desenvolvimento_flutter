import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductScreen extends StatefulWidget {
  //***VARIAVEIS***
  ProductData product;

  //***CONSTRUTOR***
  ProductScreen(this.product);

  @override
  //Para enviar o parâmetro do construtor ao State é dessa forma
  State<ProductScreen> createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  //***VARIAVEIS DO STATE***
  late ProductData product;

  //***CONSTRUTOR DO STATE
  //OBS.: recebendo o parâmetro deste jeito, vai evitar de ficar chamando o widget para ficar chamando a variável da classe
  _ProductScreenState(this.product);

  String size = "";

  @override
  Widget build(BuildContext context) {
    //Esta variável já está recebendo o primaryColor do tema
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: AnotherCarousel(
              //Aqui está pegando cada url da imagem e retornando a imagem baseado na url
              //E esta sendo feito um por um com o comando map
              images: product.images.map((url){
                return NetworkImage(url);
              }).toList(),
              //OBS.: esses dot... fazem referência ao botão que fica em cima das imagens no carrousel
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3, //Este maxLines é o limitador do máximo de linhas permitidas
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                //Esta parte do SizedBox é a parte do quadrinho que ficará os tamanhos das roupas
                SizedBox(
                  height: 34.0,
                  child: GridView(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      //Este scrollDirection é o que vai definir em qual direção vai ficar; neste caso ficará na horizontal
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.5,
                      ),
                      //Este parte do children está pegando cada valor da lista com o map e deixando dentro de um quadrado com o tamanho
                      children: product.sizes.map((s){
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              size = s;
                            });
                          },
                          //Este Container é a parte que conterá os quadradinhos com os tamanhos das roupas
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                color: s == size ? primaryColor : Colors.grey.shade500,
                                width: 3.0
                              ),
                            ),
                            width: 50.0,
                            alignment: Alignment.center,
                            child: Text(s),
                          ),
                        );
                      }).toList(),
                  ),
                ),
                SizedBox(height: 16.0,),
                //Este SizedBox será o responsável por deixar o botão no tamanho fixo
                SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                       backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)
                        )
                      ),
                      onPressed: size.isNotEmpty ? (){} : null,
                      child: Text(
                        "Adicionar ao Carrinho",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white
                        ),
                      ),
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Descrição",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16.0
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
