import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//ESTA CLASSE É RESPONSÁVEL DE MOSTRAR OS TAMANHOS DO PRODUTO NA TELA, E COM FUNÇÃO DE VALIDAÇÃO, E COM BOTÃO DE ADICIONAR OUTROS TAMANHOS
class ProductsSize extends FormField<List>{

  ProductsSize({
    required List initialValue,
    required FormFieldSetter<List> onSaved,
    required FormFieldValidator<List> validator
  }) : super(
    initialValue: initialValue,
    onSaved: onSaved,
    validator: validator,
    builder: (state){
      return SizedBox(
        height: 34,
        child: GridView(
          padding: EdgeInsets.symmetric(vertical: 4),
          scrollDirection: Axis.horizontal, //este serve para mostrar em qual direção está sendo deslizado
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 8,
            childAspectRatio: 0.5
          ),
          children: state.value!.map((size){
            return GestureDetector(
              onLongPress: (){
                state.didChange(state.value!..remove(size)); //aqui está removendo o item, clicando e segurando
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.pinkAccent,
                    width: 3
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  size,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            );
          }).toList()..add(
          GestureDetector(
            onTap: (){},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: Colors.pinkAccent,
                      width: 3
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "+",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ),
        ),
      ) ;
    }
  );

}