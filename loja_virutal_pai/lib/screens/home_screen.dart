import 'package:flutter/material.dart';
import 'package:loja_virutal_pai/screens/login_screen.dart';
import 'package:loja_virutal_pai/widgets/item_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Roupas e utensílios"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginScreen())
              );
            },
            icon: Icon(Icons.login_outlined, color: Colors.white, size: 30,)
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 70),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1
          ),
          children: [
            ItemMenu(Icons.man, "Masculina"),
            ItemMenu(Icons.woman, "Feminina"),
            ItemMenu(Icons.accessibility, "Jovem"),
            ItemMenu(Icons.child_friendly, "Infantil"),
            ItemMenu(Icons.list, "Utensílios"),
          ],
        ),
      ),
    );
  }
}
