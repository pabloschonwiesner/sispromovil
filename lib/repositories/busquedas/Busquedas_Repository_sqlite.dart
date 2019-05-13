import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:sispromovil/repositories/initDB.dart';
import 'package:sispromovil/models/BusquedaModel.dart';

class BusquedaProvider {
  BusquedaProvider._();
  static final BusquedaProvider db = BusquedaProvider._();
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

  addBusqueda(String query) async {
    final db = await database;
    // var table = await db.rawQuery('SELECT MAX(id) +1 from Busquedas');
    // var idSiguiente = table.first['id'];
    var res = await db.rawInsert('INSERT INTO Busquedas (busqueda) VALUES (?)', [query]);
    print(res);
  }

  deleteBusqueda(int id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM Busquedas WHERE id = ?', [id]);
  }
  

}
