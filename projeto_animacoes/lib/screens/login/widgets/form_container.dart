import 'package:flutter/material.dart';
import 'package:projeto_animacoes/screens/login/widgets/input_field.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
         child: Column(
           children: [
           //Aqui está chamando a classe que vai criar os campos de texto
           InputField(
               hint: "Username",
               obscure: false,
               icon: Icons.person_outline
           ),
           InputField(
               hint: "Password",
               obscure: true,
               icon: Icons.lock_outline
           ),
           ],
         )
      ),
    );
  }
}
