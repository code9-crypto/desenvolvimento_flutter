//**** ESTA CLASSE SERÁ USADA PARA AJUDAR A RECUPERAR OS DADOS DO BANCO DE DADOS

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// *** COLUNAS DA TABELA DO BANCO DE DADOS
final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String phoneColumn = "phoneColumn";
final String emailColumn = "emailColumn";
final String imgColumn = "imgColumn";

class ContactHelper{

  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  //Contrutor nomeado
  ContactHelper.internal();

  late Database _db;

  //Esta função irá retornar o banco de dados caso já esteja criado(será populado); caso não então irá criar um banco novo e depois retornará este banco novo e vazio
  Future<Database>get db async{
    if( _db != null ){
      return _db;
    }else{
      _db = await initDb();
      return _db;
    }
  }

  //ESTA FUNÇÃO ESTÁ PEGANDO O CAMINHO E O ARQUIVO DO BANCO DE DADOS PARA DEPOIS CRIÁ-LO
  Future<Database> initDb() async{
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contacts.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async{
      await db.execute(
        "CREATE TABLE $contactTable("
            "$idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT"
            ")"
      );
    });
  }

  //SALVANDO OS DADOS NO BANCO
  Future<Contact> saveContact(Contact contact) async{
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  //PEGANDO OS DADOS DO BANCO E RETORNANDO O PRIMEIRO VALOR ENCONTRADO
  Future<Contact?> getContact(int id) async{
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(
      contactTable,
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
      where: "$idColumn = ?",
      whereArgs: [id]
    );
    if( maps.length > 0 ){
      return Contact.fromMap(maps.first);
    }else{
      return null;
    }
  }
}

class Contact{

  //ATRIBUTOS
  late int id;
  late String name;
  late String email;
  late String phone;
  late String img;

  //PEGANDO OS DADOS DO MAP E PASSANDO PARA OS ATRIBUTOS DA CLASSE
  Contact.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  //TRANSFORMANDO OS ATRIBUTOS DA CLASSE PARA MAP
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
    };
    if( id != null ){
      map[idColumn] = id;
    }
    return map;
  }

  //EXIBINDO OS DADOS DE FORMA MAIS AMIGÁVEL
  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
  }
}