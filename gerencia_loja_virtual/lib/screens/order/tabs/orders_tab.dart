import 'package:flutter/material.dart';

import '../widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index){
          return OrderTile();
        }
      ),
    );
  }
}
