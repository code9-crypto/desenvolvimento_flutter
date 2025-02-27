import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  //runApp() -> é a função que roda o app
  runApp(const MyApp());
}

//Configurações do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //MaterialApp() -> é o parâmetro que da função runApp(), que diz qual será a tela home
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Instancia a classe da home page
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  String texto = "";

  void decrement() {
    //Este é o método que faz alteração na tela
    setState(() {
      count--;
    });
  }

  void increment() {
    setState(() {
      count++;
    });
  }

  void download() {
    setState(() {
      texto = "Baixando...";
    });
  }

  void upload() {
    setState(() {
      texto = "Enviando...";
    });
  }

  bool get isEmprty => count == 0;
  bool get isFull => count == 20;

  @override
  Widget build(BuildContext context) {
    //Scaffold é a função mais utilizada para criar as telas
    return Scaffold(
      //Cor de fundo
      backgroundColor: Colors.red,
      //body é o corpo da tela
      //Column é a função que deixará todo o conteúdo organizado de forma vertical
      body: Container(
        //Inserindo imagem de fundo
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/imagens/imagem.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //parâmetro nomeado children é a aquele receberá mais de um filho
          //filhos da Column
          children: [
            Text(
              "CABEÇALHO",
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "$texto",
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: download,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.grey,
                    fixedSize: const Size(150, 50),
                  ),
                  child: Text(
                    "Download",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                TextButton(
                  onPressed: upload,
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fixedSize: const Size(150, 50),
                      backgroundColor: Colors.grey),
                  child: Text(
                    "Upload",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
            Text(
              "-" * 80,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              isFull ? "Lotado" : "Pode entrar!",
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
            Text(
              '$count',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: isFull ? Colors.red : Colors.white,
                  fontSize: 60),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //Filhos da Row
              children: [
                TextButton(
                  onPressed: isEmprty ? null : decrement,
                  child: Text(
                    "Saiu",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: isEmprty
                          ? Colors.white.withOpacity(0.2)
                          : Colors.white,
                      fixedSize: const Size(100, 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      )),
                ),
                const SizedBox(
                  width: 42,
                ),
                TextButton(
                  onPressed: isFull ? null : increment,
                  child: Text(
                    "Entrou",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor:
                          isFull ? Colors.white.withOpacity(0.2) : Colors.white,
                      //padding: const EdgeInsets.all(32)
                      fixedSize: const Size(100, 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
