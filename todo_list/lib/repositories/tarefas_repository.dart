import 'package:shared_preferences/shared_preferences.dart';

//Esta classe é responsável por guardar os dados
class TarefasRepository{

  //No construtor da classe já foi inicializado o SharedPreferences para depois usarmos(ler ou gravar)
  TarefasRepository(){
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }


  late SharedPreferences sharedPreferences;
}