import 'package:flutter/material.dart';
import 'package:livros_voluntariado/classes/limpeza/brig_cadastro_pesquisa.dart';
import 'package:livros_voluntariado/classes/manutencao/manut_cadastro_pesquisa.dart';

class HomePrincipal extends StatefulWidget {
  const HomePrincipal({super.key});

  @override
  State<HomePrincipal> createState() => _HomePrincipalState();
}

class _HomePrincipalState extends State<HomePrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Livros dos Voluntários",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Este é o botão da manutenção
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManutCadastroPesquisa())
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: Size(150, 150)
              ),
              child: Text(
                "Manutenção",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            //Este é o botão da limpeza
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BrigCadastroPesquisa())
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fixedSize: Size(150, 150)
              ),
              child: Text(
                "Limpeza/Brigada",
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
