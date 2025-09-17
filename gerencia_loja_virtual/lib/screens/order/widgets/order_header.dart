import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("William"),
            Text("Rua flutter top")
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Preço dos produtos", style: TextStyle(fontWeight: FontWeight.w500),),
            Text("Preço total", style: TextStyle(fontWeight: FontWeight.w500),)
          ],
        )
      ],
    );
  }
}
