import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Stream Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _discounter = 0;
  final StreamController<int> _streamController = StreamController<int>(); //É possível especificar qual o tipo de dado que o StreamController irá trabalhar
  final StreamController<int> _streamController2 = StreamController();

  void _incrementCounter() {
    /*
    Quando o setState é utilizado para fazer alguma modificação na tela, toda a parte do Widget build é redesenhada e isso(em apps grandes) deixará o app muito lento
    Portanto, uma melhor e mais otimizada forma de fazer essas alterações na tela, usamos o stream porque ele fará a modificação apenas naquela área específica
    setState(() {
      _counter++;
    });*/

    _counter++;
    _discounter--;
    //desta forma, toda vez que a variável _counter sofre modificação a streamController ficará informado
    _streamController.sink.add(_counter); // aqui é a entrada do stream
    _streamController2.sink.add(_discounter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            //Agora para que seja possível mostrar na tela a modificação na variável _counter e fazer com que a streamController mostre isso
            //Será dentro de um StreamBuilder. E como explicamos acima, só será refeito apenas a área que espeficamos e NÃO A BUILD INTEIRA
            //OBS.: este StreamBuilder cria um listener para que quando houver uma modificação no stream, ele notificar o _streamController
            StreamBuilder(
              initialData: 0, //este parâmetro deixa um valor inicial a fim de não aparecer o valor null
              stream: _streamController.stream, //aqui é a saída do stream
              builder: (context, snapshot){
                return Text(
                  '${snapshot.data}', //o valor vem do stream, que por conseguinte vai para o snapshot. E para acessar a informação é snapshot.data
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }
            ),StreamBuilder(
                initialData: 0, //este parâmetro deixa um valor inicial a fim de não aparecer o valor null
                stream: _streamController2.stream, //aqui é a saída do stream
                builder: (context, snapshot){
                  return Text(
                    '${snapshot.data}', //o valor vem do stream que por conseguinte vai para o snapshot. E para acessar a informação é snapshot.data
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
