import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:sispromovil/repositories/initDB.dart';
import 'package:sispromovil/models/BusquedaModel.dart';

class BusquedaProviderBD {
  BusquedaProviderBD._();
  static final BusquedaProviderBD db = BusquedaProviderBD._();
  Database _database;
  InitDB initDB = InitDB();

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await initDB.createDB();
    return _database;
  }

  Future<List<BusquedaModel>> getBusquedas() async {
    var db = await database;
    var res = await db.rawQuery('SELECT * from Busquedas ORDER BY id DESC');
    List<BusquedaModel> listaBusquedas = res.map((busq) => BusquedaModel.fromJson(busq)).toList();
    return listaBusquedas;
  }

  Future<BusquedaModel> getBusqueda(int id) async {
    var db = await database;
    var res = await db.rawQuery('SELECT * FROM Busquedas WHERE id = $id');
    BusquedaModel busqueda;
    if(res.length > 0) {
      busqueda = BusquedaModel.fromJson(res[0]);
    }
    return busqueda;
  }

  Future<BusquedaModel> getBusquedaTexto(String texto) async {
    var db = await database;
    var res = await db.rawQuery('SELECT * FROM Busquedas WHERE busqueda = "$texto"');
    BusquedaModel busqueda;
    if(res.length > 0) {
      busqueda = BusquedaModel.fromJson(res[0]);
    }
    return busqueda;
  }

  Future<int> addBusqueda(String query) async {
    final db = await database;
    int res;
    BusquedaModel result = await getBusquedaTexto(query);
    if(result?.busqueda == null) {
      res = await db.rawInsert('INSERT INTO Busquedas (busqueda) VALUES (?)', [query]);
    } else {
      res = result.id;
    }
    return res;
  }

  deleteBusqueda(int id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM Busquedas WHERE id = ?', [id]);
  }
  

}
