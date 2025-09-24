import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';

//ENUMERADOR
//OBS.: este sempre fica acim da classe
enum SortCriteria {READY_FIRST, READY_LAST}

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

  void setOrderCriteria(SortCriteria crt){
    sort(crt);
  }

  //Função que faz a ordenação dependendo do status
  void sort(criteria){
    switch(criteria){
      case SortCriteria.READY_FIRST:
        orders.sort((a,b){
          int sa = a.get("status");
          int sb = b.get("status");

          if( sa < sb ) return 1;
          else if ( sa > sb ) return -1;
          else return 0;
        });
        break;
      case SortCriteria.READY_LAST:
        orders.sort((a,b){
          int sa = a.get("status");
          int sb = b.get("status");

          if( sa > sb ) return 1;
          else if ( sa < sb ) return -1;
          else return 0;
        });
        break;
    }
    ordersController.sink.add(orders);
  }

}