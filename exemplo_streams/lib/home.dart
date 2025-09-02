import 'package:exemplo_streams/blocs/exemplos_blocs.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    //Objeto da classe ExemplosBlocs
    final bloc = ExemplosBlocs(context);

    int counter = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Streams"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            children: [
              Icon(
                Icons.star,
                size: 60,
              ),
              //apenas o widget Text() sofrerá alteração na informação
              StreamBuilder(
                initialData: 0,
                stream: bloc.outFav, //aqui está chamando a saída da stream toda que vez que houver uma entrada no controller
                builder: (context, snapshot) {
                  return Text(
                    "Números de favoritos: ${snapshot.data}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                    ),
                  );
                }
              ),
              SizedBox(height: 25,),
              Row(
                children: [
                  Expanded(
                      child: Text("Texto do título número 1")
                  ),
                  IconButton(
                      onPressed: (){
                        counter += 2;
                        bloc.inFav.add(counter);
                      },
                      icon: Icon(Icons.star_border)
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text("Texto do título número 2")
                  ),
                  IconButton(
                      onPressed: (){
                        counter++;
                        bloc.inFav.add(counter);
                      },
                      icon: Icon(Icons.star_border)
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text("Texto do título número 3")
                  ),
                  IconButton(
                      onPressed: (){
                        counter++;
                        bloc.inFav.add(counter);
                      },
                      icon: Icon(Icons.star_border)
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text("Texto do título número 4")
                  ),
                  IconButton(
                      onPressed: (){
                        counter++;
                        bloc.inFav.add(counter);
                      },
                      icon: Icon(Icons.star_border)
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text("Texto do título número 5")
                  ),
                  IconButton(
                      onPressed: (){
                        counter++;
                        bloc.inFav.add(counter);
                      },
                      icon: Icon(Icons.star_border)
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text("Texto do título número 6")
                  ),
                  IconButton(
                      onPressed: (){
                        counter++;
                        bloc.inFav.add(counter);
                      },
                      icon: Icon(Icons.star_border)
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text("Texto do título número 7")
                  ),
                  IconButton(
                      onPressed: (){
                        counter++;
                        bloc.inFav.add(counter);
                      },
                      icon: Icon(Icons.star_border)
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text("Texto do título número 8")
                  ),
                  IconButton(
                      onPressed: (){
                        counter++;
                        bloc.inFav.add(counter);
                      },
                      icon: Icon(Icons.star_border)
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
