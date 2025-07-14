import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

//ESTA É A CLASSE RESPONSÁVEL POR CUIDAR DAS FUNÇÕES REFERENTE AO CARRINHO
class CartModel extends Model{

  UserModel? user;

  List<CartProduct> products = [];

  bool isLoading = false;

  String? couponCode;
  int discountPercentage = 0;

  CartModel(this.user){
    if( user!.isLoogedIn() ){
      loadCartItens();
    }
  }

  //Para acessar as funções desta classe de qualquer lugar do app
  //Essa declaração fará isso e poderemos acessar de forma bem simples
  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  //Aqui está adicionando o item ao carrinho(tanto na lista, quanto no firebase)
  void addCartItem(CartProduct cProd){
    products.add(cProd);
    
    FirebaseFirestore.instance.collection("users").doc(user?.firebaseUser?.uid).collection("cart").add(cProd.toMap()).then((ref){
      cProd.cid = ref.id;
    });

    notifyListeners();
  }

  //Aqui está removendo o item do carrinho(tanto na lista, quanto no firebase)
  void removeCartItem(CartProduct cProd){
    FirebaseFirestore.instance.collection("users").doc(user?.firebaseUser?.uid).collection("cart").doc(cProd.cid).delete();

    products.remove(cProd);

    notifyListeners();
  }

  //Esta função está decrementando os itens no banco de dados e também do atributo quantity
  void decProduct(CartProduct cProd){
    cProd.quantity = cProd.quantity! - 1;

    FirebaseFirestore.instance.collection("users").doc(user!.firebaseUser!.uid).collection("cart").doc(cProd.cid).update(cProd.toMap());

    notifyListeners();
  }

  //Esta função está incrementando os itens no banco de dados e também do atributo quantity
  void incProduct(CartProduct cProd){
    cProd.quantity = cProd.quantity! + 1;

    FirebaseFirestore.instance.collection("users").doc(user!.firebaseUser!.uid).collection("cart").doc(cProd.cid).update(cProd.toMap());

    notifyListeners();
  }

  //Esta função fará o carregamento dos itens que estão no carrinho do banco de dados
  void loadCartItens() async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection("users").doc(user!.firebaseUser!.uid).collection("cart").get();
    products = query.docs.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }

  void setCupom(String cuponCode, int discPercent){
    this.couponCode = cuponCode;
    this.discountPercentage = discPercent;
  }


}