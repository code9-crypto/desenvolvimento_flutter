import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  //***VARIÁVEIS****
  late IconData icon;
  late String text;

  //***CONSTRUTORES****
  DrawerTile({super.key});
  DrawerTile.loja(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    //Está sendo retornado o Material para que seja possível causar um efeito ao clicar no item
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){

        },
        child: Container(
          height: 60.0,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32.0,
                color: Colors.black,
              ),
              SizedBox(width: 32.0,),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
