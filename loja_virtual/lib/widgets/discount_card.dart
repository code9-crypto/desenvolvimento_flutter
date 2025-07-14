import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Cupom de desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite seu cupom"
              ),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                //Aqui está fazendo que, quando o botão de enviar/submit do teclado for clicado, será feito uma busca no banco de dados pelo desconto digitado
                //OBS.: a busca está sendo feito nos documentos/ID's da coleção cupons
                //Se o documento digitado no campo de texto for encontrado, então o cupom será aplicado; caso não, não terá desconto
                FirebaseFirestore.instance.collection("cupons").doc(text).get().then((docSnap) {
                  if (docSnap.data() != null) {
                    CartModel.of(context).setCupom(text, docSnap.data()!["percent"]);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Desconto de ${docSnap.data()!["percent"]}% aplicado!"),
                          backgroundColor: Theme.of(context).primaryColor,
                        )
                    );
                  }else{
                    CartModel.of(context).setCupom("", 0);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Cupom não existente!"),
                          backgroundColor: Colors.redAccent
                        )
                    );
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
