import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sispromovil/repositories/registro/Registro_Repository.dart';
import 'package:sispromovil/models/RegistroModel.dart';

class InitDB {
  Directory documentDirectory; 
  String path;
  final _registroRepository = RegistroRepository();

  InitDB();
  
  createDB() async {    
    documentDirectory = await getApplicationDocumentsDirectory();
    path = join(documentDirectory.path, 'SisproMovil.db');
    var db = openDatabase(
      path, 
      version: 1,
      onOpen: (db) {},
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    
    RegistroModel _registro = await _registroRepository.fetchRegistro('DEMO15');
    String _servidor = _registro.data[0].servidor;
    await db.execute("CREATE TABLE Parametros (id INTEGER PRIMARY KEY, planta TEXT, codigo TEXT, servidor TEXT, seleccionada int)");
    await db.execute("CREATE TABLE Busquedas (id INTEGER PRIMARY KEY, busqueda TEXT)");

    var q = await db.rawQuery('SELECT * FROM Parametros WHERE id =  1 and codigo = "DEMO15"');
    if(q.isEmpty) {
      await db.rawInsert('INSERT INTO Parametros (id, planta, codigo, servidor, seleccionada) VALUES(?,?,?,?,?)',
      [1, 'Planta Demo', 'DEMO15', _servidor, 1]);
    }
    print('Tablas Creadas');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if(newVersion > oldVersion) {
      // db.execute("CREATE TABLE Busquedas (id INTEGER PRIMARY KEY, busqueda TEXT)");
      db.close();
      deleteDatabase(path);
      print('Tablas Actualizadas');
    }
  }

  void _onDowngrade(Database db, int oldVersion, int newVersion) {
    if(oldVersion > newVersion) {
      db.close();
      deleteDatabase(path);
      print('DB eliminada');
    }
  }

}