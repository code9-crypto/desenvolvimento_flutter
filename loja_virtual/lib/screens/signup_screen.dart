import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  //***VARIÁVEIS***
  final _formKey = GlobalKey<
      FormState>(); // Para que seja possível fazer a validação, será necessário criar esta variavel recebendo um GlobalKey()

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        // É necessário que a variável do tipo GlobalKey(criada lá em cima) seja declarada no parâmetro key dentro do Form
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            //ESTE É O CAMPO NOME
            TextFormField(
              autofocus: true,
              //Este parâmetro nomeado validator, será usado para fazer a validação do email
              validator: (nome) {
                if (nome!.isEmpty) {
                  return "Nome inválido";
                }
              },
              keyboardType: TextInputType.emailAddress,
              //A configuração do campo de texto, fica dentro deste decoration: InputDecoration()
              decoration: InputDecoration(
                  hintText: "fulano de tal",
                  //aqui é o item que mostra uma dica do campo(semelhante a um placeholder)
                  labelText:
                      "Nome completo" // aqui é o item que mostra o texto antes de ser clicado
                  ),
            ),
            SizedBox(
              height: 16.0,
            ),
            //ESTE É O CAMPO DE EMAIL
            TextFormField(
              autofocus: true,
              //Este parâmetro nomeado validator, será usado para fazer a validação do email
              validator: (email) {
                if (email!.isEmpty || !email.contains("@")) {
                  return "E-mail inválido";
                }
              },
              keyboardType: TextInputType.emailAddress,
              //A configuração do campo de texto, fica dentro deste decoration: InputDecoration()
              decoration: InputDecoration(
                  hintText: "fulano@email.com",
                  //aqui é o item que mostra uma dica do campo(semelhante a um placeholder)
                  labelText:
                      "Digite seu email" // aqui é o item que mostra o texto antes de ser clicado
                  ),
            ),
            SizedBox(
              height: 16.0,
            ),
            //ESTE É O CAMPO DE SENHA
            TextFormField(
              validator: (senha) {
                if (senha!.isEmpty || senha.length < 6) {
                  return "Senha inválida";
                }
              },
              decoration: InputDecoration(
                  hintText: "********",
                  //aqui é o campo que mostra uma dica do campo
                  labelText: "Digite sua senha"),
              obscureText: true,
              obscuringCharacter: "*",
            ),
            SizedBox(
              height: 16.0,
            ),
            //ESTE É O CAMPO ENDEREÇO
            TextFormField(
              validator: (end) {
                if (end!.isEmpty) {
                  return "Endereço inválido";
                }
              },
              decoration: InputDecoration(labelText: "Digite endereço"),
            ),
            SizedBox(
              height: 16.0,
            ),
            //Este SizedBox está sendo usado para deixa o botão mais alto, por causa da propriedade height
            //ESTA É A PARTE DO BOTÃO DE ENTRAR
            SizedBox(
              height: 64.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                //Aqui neste onPressed é possível fazer a validação no form, pois: Foi criado a GlobalKey, declarado dentro da key no Form e criado o validator em cada TextFormField
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.reset(); //Este comando faz com que os campos sejam apagados
                  }
                },
                child: Text(
                  "Criar conta",
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
