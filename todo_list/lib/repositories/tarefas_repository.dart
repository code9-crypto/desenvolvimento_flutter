import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

//Como a chave do MAP é padrão, então foi criado uma constante para este valor
//OBS.: Esta constante foi criada fora da classe
const String chaveListaTarefa = "lista_tarefas";

//Esta classe é responsável por guardar os dados
class TarefasRepository{

  /* ------------------------------ CONSTRUTOR ------------------------------------- */
  //No construtor da classe já foi inicializado o SharedPreferences para depois usarmos(ler ou gravar)
  /*TarefasRepository(){
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
      print(sharedPreferences.getString("lista_tarefas"));
    });
  }*/

  /* --------------------- ATRIBUTOS ------------------------------ */
  late SharedPreferences sharedPreferences; //Atributo usado para salvar os dados no dispostivo


  /* -------------- MÉTODOS ----------------- */

  //Este método retornará o que foi salvo no dispositivo e será chamado apenas uma vez toda vez que o app for iniciado
  Future<List<Todo>> getListaTarefas() async{
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(chaveListaTarefa) ?? '[]'; //se o valor for nulo então a variável receberá colchetes vazio, senão então receberá a lista salva
    final List jsonDecoded =  json.decode(jsonString) as List; //aqui estou decodificando o json e transformando numa lista a atribuindo a uma variável
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList(); //aqui está criando uma nova lista de objetos com o método map()
  }


  //Como na classe Todo tem a função para conversão em JSON, este método entende isso claramente
  //E só assim conseguiremos fazer a conversão;
  //Caso a função na classe Todo não fosse declarada, ocorreria um erro na conversão
  void saveListaTarefas(List<Todo> tarefas){
    final String jsonString  = json.encode(tarefas);

    //Salvando a lista no dispositivo
    //O formato de salvamento é tipo json
    sharedPreferences.setString(chaveListaTarefa, jsonString);
  }

}