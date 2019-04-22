import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sqflite/sqflite.dart';

class PlantaProvider {
  PlantaProvider._();
  static final PlantaProvider db = PlantaProvider._();
  Database _database;
  

  Future<Database> get database async {

    if (_database != null) return _database;
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
    if(q.isEmpty) {
      res = await db.rawInsert('INSERT INTO Parametros (id, planta, codigo, servidor, puerto, seleccionada) VALUES(?,?,?,?,?,?)',
      [1, 'Planta Demo', 'DEMO15', 'http://192.168.1.79/', 3002, 1]);
    }
    return res;
  }

  addPlanta(PlantaModel planta) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id) +1 as id from Parametros");
    var idSiguiente = table.first['id'];
    await db.rawInsert("INSERT INTO Parametros (id, planta, codigo, servidor, puerto, seleccionada) VALUES (?,?,?,?,?,?)",
    [idSiguiente, planta.planta, planta.codigo, planta.servidor, planta.puerto,0]);
    
  }

  Future<List<PlantaModel>> getListPlantas() async {
    final db = await database;
    var res = await db.query('Parametros');
    List<PlantaModel> listPlantas = res.map((item) => PlantaModel.fromMap(item)).toList();
    return listPlantas;
  }

  getPlanta(int id) async {
    final db = await database;
    var res = await db.query('Parametros', where: 'id = ?', whereArgs: [id]);
    return PlantaModel.fromMap(res.first);
  }

  getPlantaSelect() async {
    final db = await database;
    var res = await db.query('Parametros', where: 'seleccionada = ?', whereArgs: [1]);
    return PlantaModel.fromMap(res.first);
  }

  updatePlanta(PlantaModel planta) async {
    final db = await database;
    await db.update('Parametros', planta.toMap(), where: "id = ?", whereArgs: [planta.id]);    
  }

  deletePlanta(PlantaModel planta) async {
    final db = await database;
    db.delete('Parametros', where: 'id = ?', whereArgs: [planta.id]);
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

