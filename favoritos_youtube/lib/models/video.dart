class Video{

  late final String id;
  late final String title;
  late final String thumb;
  late final String channel;

  Video({required this.id, required this.title, required this.thumb, required this.channel});

  //Quando chamar este construtor(que recebe tipo json/map), será retornado um novo objeto video com os todos os parâmetros descritos no retorno
  factory Video.fromJson(Map<String, dynamic> json){
    if( json.containsKey("id") ) {
      return Video(
          id: json["id"]["videoId"],
          title: json["snippet"]["title"],
          thumb: json["snippet"]["thumbnails"]["high"]["url"],
          channel: json["snippet"]["channelTitle"]
      );
    } else {
      return Video(
        id: json["id"],
        title: json["title"],
        thumb: json["thumb"],
        channel: json["channel"]
      );
    }

  }

  Map<String, dynamic> toJson(){
    return {
      "videoId" : id,
      "title" : title,
      "thumb" : thumb,
      "channel" : channel
    };
  }
}