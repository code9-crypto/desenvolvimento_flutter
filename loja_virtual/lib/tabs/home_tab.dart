import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    //Este construtor Stack() permite que os itens sejam colocados em cima do fundo da tela
    return Stack(
      children: [
        _buildBodyBack(),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              //este atributo vai deixar a barra flutuante no topo da tela
              snap: true,
              //este atributo permite que a barra seja exibida mesmo quando não estiver aparecendo na tela
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  "Novidades",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
            ),
            //Este construtor é aquele que fará a exibição dos widgets que virão no futuro
            FutureBuilder(
                //Este é o atributo que recebe os dados que virão do futuro
                future: FirebaseFirestore.instance
                    .collection("home")
                    .orderBy("pos")
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    //Este construtor SliverToBoxAdapter() será usado para adaptar um CircleProgressIndicator
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  } else {
                    //Esta codificação está exibindo as imagens(salvas como link no firebase) de forma customizada e suavemente
                    return SliverToBoxAdapter(
                      child: GridView.custom(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 2,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
                          pattern: snapshot.data!.docs.map((e) {
                            return QuiltedGridTile(e['y'], e['x']);
                          }).toList(),
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          //Este FadeInImage.memoryNetwork -> permite exibir a imagem de forma mais suave junto com o kTransparentImage
                          (context, index) => FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: snapshot.data!.docs[index]['image'],
                            fit: BoxFit.cover,
                          ),
                          childCount: snapshot.data!.docs.length,
                        ),
                      ),
                    );
                  }
                })
          ],
        )
      ],
    );
  }

  //***FUNÇÕES****

  //Esta função vai retornar um Container com um fundo em degradê de cor rosa mais escura para mais clara
  Widget _buildBodyBack() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 211, 118, 130),
          Color.fromARGB(255, 253, 181, 168)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      );
}
