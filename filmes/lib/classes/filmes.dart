import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Filmes extends StatefulWidget {
  const Filmes({super.key});

  @override
  State<Filmes> createState() => _FilmesState();
}

class _FilmesState extends State<Filmes> {
  
  //Inicializando a webview
  final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse("https://megafilmeshdz.space/"));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
