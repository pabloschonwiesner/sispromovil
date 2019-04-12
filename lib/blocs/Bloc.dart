import 'dart:async';
import './Validators.dart';
import 'package:sispromovil/bd/ParamsModel.dart';

class Bloc with Validators {
  final _searchController = StreamController<String>.broadcast();
  final _plantaController = StreamController<ParamsModel>.broadcast();

  //agregar datos al stream
  Function(String) get changeSearchController => _searchController.sink.add;
  Function(ParamsModel) get changePlantaController => _plantaController.sink.add;

  //recuperar datos del stream
  Stream<String> get getSearchController => _searchController.stream.transform(validateSearch);
  Stream<dynamic> get getPlantaController => _plantaController.stream.transform(validatePlanta);

  void dispose() {
    _searchController.close();
    _plantaController.close();
  }
}

final bloc = Bloc();


