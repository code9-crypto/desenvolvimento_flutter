import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

import '../screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  //***VARIÁVEIS****
  late String type;
  late ProductData product;

  //***CONSTRUTORES****
  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    //A diferença entre o inkwell e o gestureDetector, é que no inkWell quando clicado apresenta um pequeno efeito de clique
    return InkWell(
      //Quando o Card for clicado, será redirecionado para à página individual do produto em si
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(product))
        );
      },
      child: Card(
        //Aqui é onde fica a parte dos produtos em grade
        child: type == "grid"
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Esse Construtor AspectRatio é responsável por definir um tamanho fixo da imagem em vários dispositivos diferentes
            AspectRatio(
              aspectRatio: 0.85,
              child: Image.network(
                product.images[0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "R\$ ${product.price}",
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        )
        //Aqui é a parte onde fica os produtos em lista
            : Row(
          children: [
            //Para que seja possível manter a proporção da imagem com o texto, então usamos um construtor Flexible com o parâmetro flex: 1
            Flexible(
              child: Image.network(
                product.images[0],
                fit: BoxFit.cover,
                height: 250.0,
              ),
              flex: 1,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "R\$ ${product.price}",
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
