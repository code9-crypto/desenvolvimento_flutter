import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/cart_model.dart';

class CartPrice extends StatelessWidget {

  final VoidCallback buy;

  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child:
            ScopedModelDescendant<CartModel>(builder: (model, context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Resumo do pedido",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 12.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal"),
                  Text("R\$ 0.00")
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Desconto"),
                  Text("R\$ 0.00")
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Entrega"),
                  Text("R\$ 0.00")
                ],
              ),
              Divider(),
              SizedBox(height: 12.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: TextStyle(fontWeight: FontWeight.w500),),
                  Text("R\$ 0.00", style: TextStyle(color: Color.fromARGB(255, 4, 125, 141), fontSize: 16.0))
                ],
              ),
              SizedBox(height: 12.0,),
              ElevatedButton(
                onPressed: (){},
                child: Text("Finalizar pedido", style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 4, 125, 141),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  )
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
