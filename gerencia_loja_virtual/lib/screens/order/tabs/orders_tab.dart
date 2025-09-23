import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_loja_virtual/screens/order/blocs/orders_bloc.dart';
import '../widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {

    //BLOCS
    final orderBloc = BlocProvider.of<OrdersBloc>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: StreamBuilder(
        stream: orderBloc.outOrders,
        builder: (context, snapshot) {
          if( !snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),),
            );
          }else if( snapshot.data.length == 0 ){
            return Center(
              child: Text("Nenhum pedido encontrado", style: TextStyle(color: Colors.pinkAccent),),
            );
          }else{
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return OrderTile(snapshot.data[index]);
                }
            );
          }
        }
      ),
    );
  }
}
