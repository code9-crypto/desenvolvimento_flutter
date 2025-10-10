import 'package:flutter/material.dart';

//ESTA CLASSE É RESPONSÁVEL POR CRIAR O CAMPO DE TEXTO
class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final String labelTxt;
  final TextInputType input;
  final Stream<String> stream;
  final Function(String) onChanged;

  const InputField(
      {super.key,
      required this.icon,
      required this.hint,
      required this.obscure,
      required this.labelTxt,
      required this.input,
      required this.stream,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: stream, //no parâmetro stream do construtor StreamBuilder, eu sempre passo a função ou método de saída do StreamController
        builder: (context, snapshot) {
          return TextField(
            onChanged: onChanged,
            keyboardType: input,
            decoration: InputDecoration(
                icon: Icon(
                  icon,
                  color: Colors.white,
                ),
                hintText: hint,
                labelText: labelTxt,
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                errorText: (snapshot.hasError ? snapshot.error : "") as String, //aqui está sendo verificado se tem erro na saída da stream; se houver mostrará o erro, se não ficará em branco
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent),
                ),
                contentPadding:
                    EdgeInsets.only(left: 5, right: 30, bottom: 30, top: 30)),
            style: TextStyle(color: Colors.white),
            obscureText: obscure,
            obscuringCharacter: "*",
          );
        });
  }
}
