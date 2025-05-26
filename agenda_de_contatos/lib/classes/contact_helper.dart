//**** ESTA CLASSE SERÁ USADA PARA AJUDAR A RECUPERAR OS DADOS DO BANCO DE DADOS

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// *** COLUNAS DA TABELA DO BANCO DE DADOS E O NOME DA TABELA
final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String phoneColumn = "phoneColumn";
final String emailColumn = "emailColumn";
final String imgColumn = "imgColumn";


//ESTA É A CLASSE QUE FAZ A CONEXÃO AO BANCO DE DADOS
class ContactHelper{

  //PADRÃO DE PROJETO - SINGLETON
  static final ContactHelper _instance = ContactHelper.internal();
  factory ContactHelper() => _instance;
  //Contrutor nomeado
  ContactHelper.internal();

  Database? _db;

  //Esta função irá retornar o banco de dados caso já esteja criado(será populado); caso não então irá criar um banco novo e depois retornará este banco novo e vazio
  Future<Database?> get db async{
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
    Database? dbContact = await db;
    contact.id = await dbContact!.insert(
        contactTable,
        contact.toMap()
    ); //os dados estão sendo salvos como MAP, ou seja, chave:valor
    return contact;
  }

  //PEGANDO OS DADOS DO BANCO E RETORNANDO O PRIMEIRO VALOR ENCONTRADO
  Future<Contact?> getContact(int id) async{
    Database? dbContact = await db;
    List<Map> maps = await dbContact!.query(
      contactTable,
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
      where: "$idColumn = ?",
      whereArgs: [id]
    );//quando fazemos uma query no banco, o seu retorno ou deve ser armazenado numa lista de map ou apenas numa variavel map
    if( maps.length > 0 ){
      return Contact.fromMap(maps.first);// aqui estou pegando o map do primeiro valor encontrado, chamando o construtor nomeado para passar os valores a cada atributo da classe
    }else{
      return null;
    }
  }

  //DELETANDO CONTATO DA TABELA
  Future<int> deleteContact(int id) async{
    Database? dbContact = await db;
    return await dbContact!.delete(
        contactTable,
        where: "$idColumn = ?",
        whereArgs: [id]
    );
  }

  //ATUALIZANDO DADOS NO BANCO
  Future<int> updateContact(Contact contact) async{
    Database? dbContact = await db;
    return await dbContact!.update(
        contactTable,
        contact.toMap(),
        where: "$idColumn = ?",
        whereArgs: [contact.id]
    );
  }

  //PEGANDO TODOS OS CONTATOS DO BANCO EM FORMA DE MAP, TRANSFORMANDO OS MAPS NUMA LISTA DE CONTATOS E RETORNANDO-OS
  Future<List<Contact>> getAllContacts() async{
    Database? dbContact = await db;
    List listMap = await dbContact!.rawQuery("SELECT * FROM $contactTable");//aqui está fazendo um select na tabela para retornar todos os contatos e seu retorno atribuindo a uma lista de maps
    List<Contact> listContact = []; //aqui foi criado uma lista de contatos, onde cada item da lista de maps será transformado para uma lista de contatos
    for(Map m in listMap){
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  //PEGANDO O NUMÉRO DE CONTATOS DO BANCO
  Future<int?> getNUmber() async{
    Database? dbContact = await db;
    return Sqflite.firstIntValue(await dbContact!.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  //FECHANDO A CONEXÃO COM O BANCO DE DADOS
  Future<void> close() async{
    Database? dbContact = await db;
    dbContact!.close();
  }
}


//ESTE É A CLASSE PARA CADA CONTATO
class Contact{

  //ATRIBUTOS
  int? id;
  String? name;
  String? email;
  String? phone;
  String? img;

  Contact();

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