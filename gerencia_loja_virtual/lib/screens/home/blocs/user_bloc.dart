import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase{

  //CONTROLADORES
  final userCtrl = BehaviorSubject();

  //Lista que irá armazenar os usuários, a qual será alimentada pelo banco
  Map<String, Map<String, dynamic>> users = {};

  //CONSTANTES
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //CONSTRUTOR
  UserBloc(super.state){

    addUserListener();

  }

  //FUNÇÕES

  //função que será chamada toda vez que houver alguma mudança na coleção de usuários(adição, modificação/atualização ou deleção)
  void addUserListener()async{
    firestore.collection("users").snapshots().listen((snapshot){ //aqui o método snapshots retornará sempre todos os dados do banco
      snapshot.docChanges.forEach((change){ //no entanto, junto com o método listen é possível usar o comando forEach para verificar apenas cada alteração

        String uid = change.doc.id;//aqui está atribuindo o ID apenas do usuário que foi afetado a uma variavel do tipo String

        //Aqui neste switch vai verificar qual o tipo da ação e conforme à ação feita no banco, será executado o case daquele tipo
        switch(change.type){
          case DocumentChangeType.added:
            users[uid] = change.doc.data()!; //toda vez que um usuário for adicionado na coleção users do banco, este método será acionado para incluir o novo ususário nesta lista
            subsToOrder(uid);
            break;
          case DocumentChangeType.modified:
            users[uid]!.addAll(change.doc.data()!); //pegando as modificações que foram feitas no banco e inserindo na lista
            userCtrl.add(users.values.toList());
            break;
          case DocumentChangeType.removed:
            users.remove(uid); //quando um usuári for deletado do banco, este também será deletado da lista
            unsubsToOrders(uid);
            userCtrl.add(users.values.toList());
            break;
        }
      });
    });
  }

  //Este método será usado para ficar observando os pedidos do usuário
  void subsToOrder(String uid){
    users[uid]!["subscription"] = firestore.collection("users").doc(uid).collection("orders").snapshots().listen((orders) async {
      int numOrders = orders.docs.length;
      double money = double.minPositive;
      for( DocumentSnapshot d in orders.docs ){
        DocumentSnapshot order = await firestore.collection("orders").doc(d.id).get();
        if( order.data.toString().isEmpty  ) continue;
          money += order.get("totalPrice");
      }

      users[uid]!.addAll(
        {
          "money" : money,
          "orders" : numOrders
        }
      );
      
      userCtrl.add(users.values.toList());
    });
  }

  //Este método será para cancelar o pedido do usuário
  void unsubsToOrders(String uid){
    users[uid]!["subscription"].cancel();
  }

}