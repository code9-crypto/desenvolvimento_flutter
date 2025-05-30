import 'package:flutter/material.dart';
import 'classes/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  runApp(MyApp());
  await Firebase.initializeApp();
  FirebaseFirestore.instance.collection("mensagens").doc("W9tmfx21u7IuQ6AK3cXo").snapshots().listen((dado){
    print(dado.data());
  });


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Chat(),
    );
  }
}
