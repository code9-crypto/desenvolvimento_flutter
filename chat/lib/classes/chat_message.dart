import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  //***VARIÁVEIS****
  Map<String, dynamic> data;
  final bool mine;

  //***CONSTRUTORES***
  ChatMessage(this.data,this.mine);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        children: [
          //Se a mensagem for minha, então será mostrada no lado esquerdo
          mine ?
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            //Este construtor CircleAvatar vai mostrar a imagem de forma circular(que veio por parâmetro no construtor)
            child: CircleAvatar(
              backgroundImage: NetworkImage(data['senderPhotoUrl']),
            ),
          ) : Container(),
          //Dentro deste Expanded é onde ficará todo o texto ou imagem
          Expanded(
            child: Column(
              crossAxisAlignment: mine ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                data['imgUrl'] != null
                    ? Image.network(data['imgUrl'])
                    : Text(
                        textAlign: mine ? TextAlign.start : TextAlign.end,
                        data['text'],
                        style: TextStyle(fontSize: 16.0),
                      ),
                Text(
                  data['senderName'],
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          //Se a mensagem não for minha, então será mostrada no lado direito
          !mine ?
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            //Este construtor CircleAvatar vai mostrar a imagem de forma circular(que veio por parâmetro no construtor)
            child: CircleAvatar(
              backgroundImage: NetworkImage(data['senderPhotoUrl']),
            ),
          ) : Container()
        ],
      ),
    );
  }
}
