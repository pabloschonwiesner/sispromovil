import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sispromovil/bd/ParamsModel.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  Database _database;
  

  Future<Database> get database async {

    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute("ALTER TABLE Parametros ADD COLUMN seleccionada INT");
    }
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "SisproMovil.db");
    var db = await openDatabase(path, version: 4, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Parametros (id INTEGER PRIMARY KEY, planta TEXT, codigo TEXT, servidor TEXT, puerto int, seleccionada int)");
    }, onUpgrade: _onUpgrade);
    addPlantaDemo();
    return db;
  }

  addPlantaDemo() async {
    final db = await database;
    var res;
    var q = await db.rawQuery('SELECT * FROM Parametros WHERE id =  1 and codigo = "DEMO15"');
    print('Prueba: $q' );
    if(q.isEmpty) {
      print('entra en el if');
      res = await db.rawInsert('INSERT INTO Parametros (id, planta, codigo, servidor, puerto, seleccionada) VALUES(?,?,?,?,?,?)',
      [1, 'Planta Demo', 'DEMO15', 'http://192.168.1.79/', 3002, 1]);
    }
    return res;
  }

  addParams(ParamsModel params) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id) +1 as id from Parametros");
    var idSiguiente = table.first['id'];
    var res = await db.rawInsert("INSERT INTO Parametros (id, planta, codigo, servidor, puerto, seleccionada) VALUES (?,?,?,?,?,?)",
    [idSiguiente, params.planta, params.codigo, params.servidor, params.puerto,0]);
    return res;
  }

  Future<List<ParamsModel>> getListParams() async {
    final db = await database;
    var res = await db.query('Parametros');
    List<ParamsModel> listParams = res.isNotEmpty ? res.map((item) => ParamsModel.fromMap(item)).toList() : [];
    return listParams;
  }

  getParams(int id) async {
    final db = await database;
    var res = await db.query('Parametros', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ParamsModel.fromMap(res.first) : null;
  }

  updateParams(ParamsModel params) async {
    final db = await database;
    var res = await db.update('Parametros', params.toMap(), where: "id = ?", whereArgs: [params.id]);
    return res;
  }

  deleteParams(int id) async {
    final db = await database;
    db.delete('Parametros', where: 'id = ?', whereArgs: [id]);
  }

  selectPlanta(int id) async {
    deseleccionarTodas();
    final db = await database;
    var res = await db.rawQuery('UPDATE Parametros SET seleccionada = 1 WHERE id = $id');
    return res;
  }

  deseleccionarTodas() async {
    final db = await database;
    var res = await db.rawQuery('UPDATE Parametros SET seleccionada = 0');
    return res;
  }

}

