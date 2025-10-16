import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart' as picker; // <<---

class ImageSource extends StatefulWidget {

  //VARIAVEIS
  late File? imagem;
  final Function(File) onImageSelected; //quando passa o tipo de dado entre parenteses na função de callback, significa que quando ela for acessada por outra classe, deverá passar parametro

  //CONSTRUTOR
  ImageSource({super.key, required this.onImageSelected, this.imagem});

  @override
  State<ImageSource> createState() => _ImageSourceState();
}

class _ImageSourceState extends State<ImageSource> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomSheet(
          onClosing: (){},
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      textStyle: TextStyle(
                          fontSize: 16
                      )
                  ),
                  //Pegando a imagem pela camera
                  onPressed: () async {
                    //Depois da versão 0.8.X a biblioteca do ImagePicker não recebe mais o tipo file, mas sim o tipo XFile
                    picker.XFile? img = (await picker.ImagePicker().pickImage(source: picker.ImageSource.camera));
                    if( img != null ){ //Por isso que aqui no if está acontecendo a conversão de XFile para file
                      File file = File(img.path);
                      imageSelected(file);
                    }

                    Navigator.of(context).pop();

                    //******* OU PODE SER ESCRITO DESTE JEITO, A QUAL TAMBÉM SURTIRÁ O MESMO EFEITO DO COMANDO DE CIMA *****
                    /*picker.ImagePicker().pickImage(source: picker.ImageSource.camera).then((img){
                      if( img != null ){
                        File file = File(img.path);
                        imageSelected(file);
                        Navigator.of(context).pop();
                      }
                    });*/
                  },
                  child: Text("Câmera")
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 16
                  )
                ),
                //Pegando a imagem pela galeria
                  onPressed: () async {
                    //Depois da versão 0.8.X a biblioteca do ImagePicker não recebe mais o tipo file, mas sim o tipo XFile
                    picker.XFile? img = await picker.ImagePicker().pickImage(source: picker.ImageSource.gallery);
                    if( img != null ){//Por isso que aqui no if está acontecendo a conversão de XFile para file
                      File file = File(img.path);
                      imageSelected(file);
                    }

                    Navigator.of(context).pop();
                  },
                  child: Text("Galeria")
              )
            ],
          )
      ),
    );
  }

  //***************** FUNÇÃO DA IMAGEM ***********************
  void imageSelected(File imagem) async {
    //Aqui no CroppedFile a lógica é semelhante ao XFile la de cima
    CroppedFile? cropedImg = await ImageCropper().cropImage(
      sourcePath: imagem.path,
    );
    if( cropedImg != null ){
      File file = File(cropedImg.path);
      widget.onImageSelected( file ); //aqui é uma função de callback, a qual esta vai retornar a imagem recortada para a classe a qual está sendo chamada
    }
  }
}
