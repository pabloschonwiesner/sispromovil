import 'dart:async';
import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sispromovil/repositories/initDB.dart';

class PlantaProvider {
  PlantaProvider._();
  static final PlantaProvider db = PlantaProvider._();
  Database _database;
  InitDB initDB = InitDB();
  

  Future<Database> get database async {
    if (_database != null) return _database;
    // if (_database != null) {
    //   initDB.createDB();
    // }
    _database = await initDB.createDB();
    return _database;
  }

  addPlanta(PlantaModel planta) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id) +1 as id from Parametros");
    var idSiguiente = table.first['id'];
    await db.rawInsert("INSERT INTO Parametros (id, planta, codigo, servidor,  seleccionada) VALUES (?,?,?,?,?)",
    [idSiguiente, planta.planta, planta.codigo, planta.servidor, 0]);
    
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
    if(res.length == 0) {
      db.rawUpdate('UPDATE Parametros SET seleccionada = 1 where id = 1').then((_) => getPlantaSelect());
    }
    return PlantaModel.fromMap(res.first);
  }

  updatePlanta(PlantaModel planta) async {
    final db = await database;
    await db.update('Parametros', planta.toMap(), where: "id = ?", whereArgs: [planta.id]);    
  }

  deletePlanta(PlantaModel planta) async {
    final db = await database;
    await db.delete('Parametros', where: "id = ?", whereArgs: [planta.id]);
    var count = await db.query('Parametros');
    var res;
    if(count.length > 1) {
      res = await db.rawQuery("SELECT MIN(id) as id from Parametros where id > 1");
    } else {
      res = await db.rawQuery("SELECT MIN(id) as id from Parametros");
    }
    var id = res.first['id'];
    db.rawUpdate('UPDATE Parametros SET seleccionada = 0').then(
      (r) => db.rawUpdate('UPDATE Parametros SET seleccionada = 1 WHERE id = $id')
    );

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

