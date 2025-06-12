import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  //***VARIÁVEIS****
  late IconData icon;
  late String text;
  late PageController controller;
  late int page;

  //***CONSTRUTORES****
  DrawerTile({super.key});
  DrawerTile.loja(this.icon, this.text, this.controller, this.page); //O controller e o page estão vindo do arquivo custom_drawer.dart que faz o controle da transição das páginas

  @override
  Widget build(BuildContext context) {
    //Está sendo retornado o Material para que seja possível causar um efeito ao clicar no item
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          //Aqui está indo para à página que veio por parâmetro no construtor
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32.0,
                color: controller.page!.round() == page ? Theme.of(context).primaryColor : Colors.grey[700]
              ),
              SizedBox(width: 32.0,),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: controller.page!.round() == page ? Theme.of(context).primaryColor : Colors.grey[700]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
