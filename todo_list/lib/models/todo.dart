//Esta classe foi criada para armazenar o titulo e a data
class Todo{

  Todo({required this.title, required this.data});

  //Este construtor nomeado é usado para transformar o JSON recuperado em uma lista de MAP
  Todo.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      data = DateTime.parse(json['data']); //Convertendo o valor string para datetime


  String title;
  DateTime data;

  //Convertendo o objeto em tipo jSON
  //OBS.: este método é uma sobrecarga para fazer conversão em JSON
  Map<String, dynamic> toJson(){
    return{
      'title': title,
      'data': data.toIso8601String() // este tipo converte o datetime de forma mais amigável, pois permite converter de volta para datetime sem muitas dificuldades
    };
  }

}
