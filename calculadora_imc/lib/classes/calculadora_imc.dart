import 'package:flutter/material.dart';

class CalculadoraImc extends StatefulWidget {
  CalculadoraImc({super.key});

  @override
  State<CalculadoraImc> createState() => _CalculadoraImcState();
}

class _CalculadoraImcState extends State<CalculadoraImc> {

  //Controladores dos campos
  final TextEditingController pesoCtrl = TextEditingController();
  final TextEditingController alturaCtrl = TextEditingController();

  //Validador de formulário - Usado sempre dentro dos TextFormFields para fazer a validação
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Variáveis
  String _textInfo = "Informe seu dados!";

  //Funções
  void _resetFields(){
    pesoCtrl.clear();
    alturaCtrl.clear();
    setState(() {
      _textInfo = "Informe seu dados!";
      _formKey = GlobalKey<FormState>(); //Resetando a formKey
    });
  }

  void _calculate(){
    setState(() {
      double peso = double.parse(pesoCtrl.text);
      double altura = double.parse(alturaCtrl.text) / 100;
      double imc = peso / (altura * altura);
      switch(imc){
        case < 18.6:
          _textInfo = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
          break;
        case >= 18.6 && < 24.9:
          _textInfo = "Peso Ideal (${imc.toStringAsPrecision(4)})";
          break;
        case >= 24.9 && < 29.9:
          _textInfo = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
          break;
        case >= 29.9 && < 34.9:
          _textInfo = "Obesidade grau I (${imc.toStringAsPrecision(4)})";
          break;
        case >= 34.9 &&  < 39.9:
          _textInfo = "Obesidade grau II (${imc.toStringAsPrecision(4)})";
          break;
        case >= 40:
          _textInfo = "Obesidade grau III (${imc.toStringAsPrecision(4)})";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Esta appBar é a barra que fica na parte de cima do aplicativo
      appBar: AppBar(
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        //Este parâmetro faz com que o título fique centralizado
        backgroundColor: Colors.green,
        //Essas actions serão, normalmente, os botões
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: Icon(Icons.refresh),
            color: Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView( //Este construtor é do ScrollView, usado para evitar o erro de quando o teclado sobresair as informações do aplicativo
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Form( //Para fazer a validação, o conteúdo da Column() deve estar dentro deste Form
          key: _formKey, // E deverá também declarar a chave criada, que foi feito lá em cima como GlobalKey
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //Este comando faz com que a linha estique ao máximo da coluna
            //Dentro das listas, sempre será escrito direto os construtores das classes
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField( //Para que tenha efeito na validação, deverá ser o TextFormFiel, pois o TextField não tem alguns parâmetros para validação
                validator: (value){ //Este parâmetro validator, recebe uma função(anônima ou não) que faz a verificação se o campo tem valor ou não
                  if( value!.isEmpty){
                    return "Insira seu peso";
                  }
                },
                controller: pesoCtrl,
                keyboardType: TextInputType.number,
                //Este é o comando que define qual o tipo de teclado que será exibido ao usuário
                decoration: InputDecoration(
                    labelText: "Peso em (kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.green),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField( //Para que tenha efeito na validação, deverá ser o TextFormFiel, pois o TextField não tem alguns parâmetros para validação
                validator: (value){ //Este parâmetro validator, recebe uma função(anônima ou não) que faz a verificação se o campo tem valor ou não
                  if( value!.isEmpty ){
                    return "Insira sua altura";
                  }
                },
                controller: alturaCtrl,
                keyboardType: TextInputType.number,
                //Este é o comando que define qual o tipo de teclado que será exibido ao usuário
                decoration: InputDecoration(
                    labelText: "Altura em (cm)",
                    //label: Text("teste"), Este parâmetro tem o mesmo efeito que o labelText
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.green),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () { //Aqui neste parâmetro chama o formKey que verifica se está validado; se estiver chamad a função para calcular, se não, exibe a mensagem de erro
                  if( _formKey.currentState!.validate() ){
                    _calculate();
                  }
                },
                child: Text(
                  "Calcular",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(50, 50),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(height: 20,),
              Text( // Este construtor é para colocar texto direto na tela
                "$_textInfo",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
