import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';

class OrdersBloc extends BlocBase{

  OrdersBloc(super.state){
    addOrdersListener();
  }

  //CONTROLLERS
  final ordersController = BehaviorSubject();

  //CONSTANTES
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //STREAMS
  Stream get outOrders => ordersController.stream;

  //VARIÁVEIS
  List<DocumentSnapshot> orders = [];

  //FUNÇÕES
  void addOrdersListener(){
    firestore.collection("orders").snapshots().listen((snapshot){
      snapshot.docChanges.forEach((change){
        String oid = change.doc.id;

        switch(change.type){
          case DocumentChangeType.added:
            orders.add(change.doc);
            break;
          case DocumentChangeType.modified:
            orders.removeWhere((order) => order.id == oid);
            orders.add(change.doc);
            break;
          case DocumentChangeType.removed:
            orders.removeWhere((order) => order.id == oid);
            break;
        }
      });

      ordersController.sink.add(orders);
    });
  }

}