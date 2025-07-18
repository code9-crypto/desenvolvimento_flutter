import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';

import '../screens/login_screen.dart';
import '../tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {

  OrdersTab();

  @override
  Widget build(BuildContext context) {
    if( UserModel.of(context).isLoogedIn() ){

      String uid = UserModel.of(context).firebaseUser!.uid;

      return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("users").doc(uid).collection("orders").get(),
        builder: ( context, snapshot ){
          if( !snapshot.hasData ){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            //Aqui está gerando uma lista de pedidos
            return ListView(
              children: snapshot.data!.docs.map((doc) => OrderTile(doc.id)).toList().reversed.toList() //aqui está pegando cada item do snapshot(pelo ID), mandando para outra classe que vai configurar o layout
              //OBS.: este reversed deixa a lista da mais recente para mais antiga
            );
          }
        }
      );

    }else{
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.view_list,
              size: 80.0,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Faça o login para acompanhar!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text(
                "Entrar",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                fixedSize: Size(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
