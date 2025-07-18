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
    //Aqui estou adicionando os dados na lista products
    products.add(cProd);

    //Aqui estou adicionando os dados na coleção users -> cart
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

  void updatePrices(){
    notifyListeners();
  }

  //Retorna o total dos produtos
  double getProductsPrice(){
    double price = 0.0;
    for(CartProduct c in products){
      if( c.pData != null ){
        price += c.quantity! * c.pData!.price;
      }
    }
    return price;
  }

  //Retorna o valor da Entrega
  double getShipPrice(){
    return 9.99;
  }


  //Retorna o valor do desconto
  double getDiscount(){
    return getProductsPrice() * (discountPercentage / 100);
  }

  Future<String?> finishOrder() async{
    if( products.length == 0 ) return null;

    isLoading = true;
    notifyListeners();

    double prodPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    //adicionando novo pedido à coleção orders
    //E pegando a referência/ID desta inserção, para que possa ser inserido na coleção users ali embaixo
    DocumentReference refOrder = await FirebaseFirestore.instance.collection("orders").add(
      {
        "clienteId":user!.firebaseUser!.uid,
        "products":products.map((products) => products.toMap()).toList(), //aqui está pegando cada item da lista products no campo do banco como array
        "shipPrice":shipPrice,
        "productsPrice":prodPrice,
        "discount":discount,
        "totalPrice":prodPrice - discount + shipPrice,
        "status":1
      }
    );

    //Inserindo o ID(que foi pego no comando de cima) na coleção users
    await FirebaseFirestore.instance.collection("users").doc(user!.firebaseUser!.uid).collection("orders").doc(refOrder.id).set(
      {
        "orderId" : refOrder.id
      }
    );

    //este comando está pagando tanto os documentos(ID'S) quanto os campos dos seus respectivos documentos
    QuerySnapshot query = await FirebaseFirestore.instance.collection("users").doc(user!.firebaseUser!.uid).collection("cart").get();

    for(DocumentSnapshot doc in query.docs){
      doc.reference.delete();
    }

    products.clear();
    couponCode = null;
    discountPercentage = 0;
    isLoading = false;
    notifyListeners();

    return refOrder.id;
  }
}