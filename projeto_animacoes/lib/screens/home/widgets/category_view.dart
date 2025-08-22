import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

  List<String> categorias = [
    "trabalho",
    "estudos",
    "profissão"
  ];

  int categoria = 0;

  void backWard(){
    setState(() {
      categoria--;
    });
  }

  void forWard(){
    setState(() {
      categoria++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: categoria > 0  ? backWard : null,
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          )
        ),
        Text(
          categorias[categoria].toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 20,
            letterSpacing: 1.2
          ),
        ),
        IconButton(
            onPressed: categoria < categorias.length - 1 ? forWard : null,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            )
        ),
      ],
    );
  }
}
