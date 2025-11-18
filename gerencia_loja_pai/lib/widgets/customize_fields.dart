import 'package:flutter/material.dart';

//ESTA CLASSE SERÁ USADA PARA RETORNAR OS CAMPOS DE TEXTOS
class CustomizeFields extends StatelessWidget {

  //VARIAVEIS
  late String? label;
  late String? Function(String?)? validator;
  late TextInputType keyBoard;
  late bool choice;
  late Widget? prefixIcon;
  late Widget? sufixIcon;
  late Stream? stream;
  late TextEditingController? controller;
  late Stream? habilita;
  late Function()? mudaVisao;

  //CONSTRUTOR
  CustomizeFields({
    super.key,
    required this.label,
    this.validator,
    required this.keyBoard,
    required this.choice,
    this.prefixIcon,
    this.sufixIcon,
    this.stream,
    this.controller,
    this.habilita,
    this.mudaVisao
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder( //este StreamBuilder está monitorando a saída do bloc controller para mudança do texto de erro
      stream: stream,
      builder: (context, snapshotError){
      return StreamBuilder( //este StreamBuilder está monitorando a saída do bloc controller para habilitar e desabilitar os campos de textos da tela de login
        stream: habilita,
        builder: (context, snapshotLoading) {
          return TextFormField(
            controller: controller,
            keyboardType: keyBoard,
            enabled: snapshotLoading.data == true ? false : true,
            onTap: mudaVisao,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: prefixIcon,
              suffixIcon: sufixIcon,
              errorText: (snapshotError.hasError
                  ? snapshotError.error
                  : null) as String?
            ),
            style: TextStyle(
                color: Colors.black
            ),
            validator: validator,
            obscureText: choice,
          );
        }
      );
    }
    );
  }
}

