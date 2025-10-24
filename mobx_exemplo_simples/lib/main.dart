import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobX Tutorial',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tutorial de Mobx'),
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

  Counter counter = Counter();

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
            Observer( //Este Observer é quem faz a reação. Este valor está sendo retornado por meio do getter count
              builder: (_) => Text(
                '${counter.count}', //aqui é o estado, ou seja, o Observable
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ),
            SizedBox(height: 30,),
            Text("Número por extenso"),
            Observer( //aqui (igual ao de cima) está obersanvando a modificação da ação. Este valor está sendo retornado por meio do getter txt
                builder: (_) => Text("${counter.texto.toUpperCase()}", style: Theme.of(context).textTheme.headlineMedium,)
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counter.increment, //aqui no onPressed fica a ação
        tooltip: 'Increment',
        child: const Icon(Icons.add, size: 30,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
      ),
    );
  }
}
