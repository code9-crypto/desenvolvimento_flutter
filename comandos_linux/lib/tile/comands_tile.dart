import 'package:comandos_linux/data/comands_data.dart';
import 'package:flutter/material.dart';
import '../screens/comand.dart';

class ComandsTile extends StatelessWidget {
  //***VARIAVEIS***
  ComandsData data;

  //***CONSTRUTORES****
  ComandsTile(this.data);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Comand(data),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.grey.shade400),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            data.titulo,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
