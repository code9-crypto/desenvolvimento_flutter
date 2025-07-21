import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Anime(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Anime extends StatelessWidget {
  const Anime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/heartbeat.gif")
            )
          ),
        ),
      ),
    );
  }
}




