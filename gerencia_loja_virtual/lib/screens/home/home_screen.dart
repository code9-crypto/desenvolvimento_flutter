import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("TabBarView teste"),
          centerTitle: true,
          bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person_outline),),
                Tab(icon: Icon(Icons.list),)
              ],
            indicatorColor: Colors.black,
          ),
          actions: [
            IconButton(
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.exit_to_app)
            )
          ],
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
            children:[
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.green,
              )
            ]
        ),
      ),
    );
  }
}
