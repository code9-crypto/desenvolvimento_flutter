import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'order_header.dart';

class OrderTile extends StatelessWidget {

  final DocumentSnapshot order;
  final states = [
    "", "Em preparação", "Em transporte", "Aguardando entrega", "Entregue"
  ];

  OrderTile(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Text(
          "#${order.id.substring(order.id.length - 7, order.id.length)} - ${states[order.get("status")]}",
          style: TextStyle(
            color: order.get("status") != 4 ? Colors.grey.shade800 : Colors.green
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OrderHeader(order),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: order.get("products").map<Widget>((prd){ //Para que seja possível retornar um widget por meio do map, será necessário tipar o map deste jeito .map<Widget>
                    return ListTile(
                      title: Text(prd["product"]["title"]),
                      subtitle: Text(prd["category"] + " / " + prd["pid"]),
                      trailing: Text(
                        prd["quantity"].toString(),
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //aqui nesta parte está vai deixar os widgets(os botões) com o maior espaçamento entre eles
                  children: [
                    TextButton(
                      onPressed: (){
                        FirebaseFirestore.instance.collection("users").doc(order.get("clientId")).collection("orders").doc(order.id).delete();
                        order.reference.delete();
                      },
                      child: Text("Excluir", style: TextStyle(color: Colors.red),)
                    ),
                    TextButton(
                        onPressed: order.get("status") > 1 ? (){

                          order.reference.update({"status": order.get("status") - 1});
                        } : null,
                        child: Text("Regredir", style: TextStyle(color: Colors.grey),)
                    ),
                    TextButton(
                        onPressed: order.get("status") < 4 ? (){
                          order.reference.update({"status": order.get("status") + 1});
                        } : null,
                        child: Text("Avançar", style: TextStyle(color: Colors.green),)
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
