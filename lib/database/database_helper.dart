import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static Database ? _database;

static Future<Database> getDatabase() async {
  if(_database != null) return _database!;

  //Define la ruta del archivo
  final String pathDB = join (await getDatabasesPath(), 'examen8.db');

  _database = await openDatabase(
    pathDB,
    version: 1,
    onCreate: (db, version) async{
      var batch = db.batch();

      batch.execute("DROP TABLE IF EXISTS usuarios;");
      batch.execute("CREATE TABLE usuarios(id INTEGER PRIMARY KEY AUTOINCREMENT, idUsuario TEXT, idCliente TEXT);");
      await batch.commit();
    }
  );
  return _database!;
}
}