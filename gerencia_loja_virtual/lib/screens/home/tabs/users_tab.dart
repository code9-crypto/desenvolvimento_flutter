import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_loja_virtual/screens/home/blocs/user_bloc.dart';
import '../widgets/user_tile.dart';

class UsersTab extends StatelessWidget {

  //CONSTRUTOR
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {

    //BLOC
    final userBloc = BlocProvider.of<UserBloc>(context); //agora este bloc terá acesso a todos os métodos da classe UserBloc, porque o BlocProvider foi colocado acima desta classe

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            onChanged: userBloc.onChangedSearch, //este método está sendo chamado do UserBloc para fazer a pesquisa do usuário
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: "Pesquisar",
              hintStyle: TextStyle(color: Colors.white),
              icon: Icon(Icons.search, color: Colors.white,),
              border: InputBorder.none
            ),
          ),
        ),
        //Esta ListView.separated() é usada com um separador entre os itens
        Expanded(
          child: StreamBuilder(
            stream: userBloc.outUsers,
            builder: (context, snapshot) {
              if( !snapshot.hasData ){
                return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),),);
              }else if( snapshot.data.toString().isEmpty ){
                return Center(
                  child: Text(
                    "Nenhum usuário encontrado!",
                    style: TextStyle(
                      color: Colors.pinkAccent
                    ),
                  ),
                );
              } else {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return UserTile(snapshot.data[index]); //passando cada item do retorno da stream para a classe UserTile
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: snapshot.data.length
                );
              }
            }
          ),
        ),
      ],
    );
  }
}
