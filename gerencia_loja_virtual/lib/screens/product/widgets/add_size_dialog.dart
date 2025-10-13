import 'package:flutter/material.dart';

class AddSizeDialog extends StatelessWidget {
  AddSizeDialog({super.key});

  //CONTROLLERS
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){
                  Navigator.of(context).pop(controller.text); //aqui estou pegando o valor do campo de texto, voltando para a tela anterior junto com o valor do campo
                },
                child: Text(
                  "Add",
                   style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
