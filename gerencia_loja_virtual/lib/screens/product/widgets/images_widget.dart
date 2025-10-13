
import 'package:flutter/material.dart';

import 'image_source.dart';

//ESTA CLASSE É RESPONSÁVEL DE MOSTRAR AS IMAGES DO PRODUTO NA TELA E COM FUNÇÃO DE VALIDAÇÃO E TAMBÉM MOSTRARÁ BOTÃO PARA TIRAR FOTO OU SELECIONAR DA GALERIA
class ImagesWidget extends FormField<List>{

  //CONSTRUTORES
  ImagesWidget({super.key, 
    final BuildContext? context,
    required FormFieldSetter<List> onSaved,
    required FormFieldValidator<List> validator,
    required List initialValue,
    bool autoValidate = false,
  }) : super(
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    builder: (state){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 124,
            padding: EdgeInsets.only(top: 16, bottom: 8),
            child: ListView(
              scrollDirection: Axis.horizontal, //esta especificação está dizendo que a lista será deslizada na horizontal
              children: state.value!.map<Widget>((img){
                return Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    child: img is String ? Image.network(img, fit: BoxFit.cover,) : Image.file(img, fit: BoxFit.cover),
                    onLongPress: (){
                      state.didChange(state.value!..remove(img)); //este dois pontos está sendo usado para retornar o valor final e NÃO O RESULTADO DA OPERAÇÃO
                    },
                  ),
                );
              }).toList()..add( //Aqui está adicionando um ícone da camera para tirar uma nova foto ou pegar da galeria
                GestureDetector(
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.white.withAlpha(50),
                    child: Icon(Icons.camera_enhance),
                  ),
                  onTap: (){
                    //Este modal vai aparecer no rodapé da tela
                    showModalBottomSheet(
                        context: context!,
                        builder: (context) => ImageSource(
                          onImageSelected: (image){
                            state.didChange(state.value!..add(image));
                          },
                        )
                    );
                  },
                )
              ),
            ),
          ),
          //ESTA PARTE É A MENSAGEM DE ERRO, QUANDO TIVER ERROR
          state.hasError ? Text(
            "${state.errorText}",
            style: TextStyle(
              color: Colors.red,
              fontSize: 12
            ),
          ) : Container()
        ],
      );
    }
  );

}