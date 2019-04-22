import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository.dart';

class BlocPlanta {
  BlocPlanta() {
    initialData();
  }

  final _repository = PlantasRepository();
  final _id = BehaviorSubject<int>();
  final _planta = BehaviorSubject<String>();
  final _codigo = BehaviorSubject<String>();
  final _servidor = BehaviorSubject<String>();
  final _puerto = BehaviorSubject<int>();
  final _seleccionada = BehaviorSubject<int>();
  final _listaPlantas = BehaviorSubject<List<PlantaModel>>();
  final _plantaAnterior = BehaviorSubject<String>();

  List<PlantaModel> _plantas;

  //cambiar datos
  Function(int) get changeId => _id.sink.add;
  Function(String) get changePlanta => _planta.sink.add;
  Function(String) get changeCodigo => _codigo.sink.add;
  Function(String) get changeServidor => _servidor.sink.add;
  Function(int) get changePuerto => _puerto.sink.add;
  Function(int) get changeSeleccionada => _seleccionada.sink.add;
  
  //obtener datos
  Observable<int> get id => _id.stream;
  Observable<String> get planta => _planta.stream;
  Observable<String> get codigo => _codigo.stream;
  Observable<String> get servidor => _servidor.stream;
  Observable<int> get puerto => _puerto.stream;
  Observable<int> get seleccionada => _seleccionada.stream;
  Observable<List<PlantaModel>> get listaPlantas => _listaPlantas.stream;
  Observable<String> get plantaAnterior => _plantaAnterior.stream;


  void initialData() async {
    llenarListaPlantas();
  }

  void llenarListaPlantas() async {
    _plantas = await _repository.getPlantas();
    for(var i = 0; i < _plantas.length; i++) {
      if(_plantas[i].seleccionada == 1) {
        changeId(_plantas[i].id);
        changePlanta(_plantas[i].planta);
        changeCodigo(_plantas[i].codigo);
        changeServidor(_plantas[i].servidor);
        changePuerto(_plantas[i].puerto);
        changeSeleccionada(_plantas[i].seleccionada);
        // changePlantaAnterior(_plantas[i].servidor);
      }
    }
    _listaPlantas.sink.add(_plantas);
  }

  void changePlantaAnterior(String plantaAnt) {
    _plantaAnterior.sink.add(plantaAnt);
  }

  void seleccionarPlanta(int id) {
    _repository.selectPlanta(id);
    llenarListaPlantas();
  }

  void agregarPlanta(PlantaModel planta) async {
    await _repository.addPlanta(planta);
    llenarListaPlantas();
  }

  void actualizarPlanta(PlantaModel planta) {
    _repository.updatePlanta(planta);
    llenarListaPlantas();
  }
  
  void deletePlanta(PlantaModel planta) {
    _repository.deletePlanta(planta);
    llenarListaPlantas();
  }

  void dispose() async {
    await _id.drain();
    _id.close();
    await _planta.drain();
    _planta.close();
    await _codigo.drain();
    _codigo.close();
    await _servidor.drain();
    _servidor.close();
    await _puerto.drain();
    _puerto.close();
    await _seleccionada.drain();
    _seleccionada.close();
    await _listaPlantas.drain();
    _listaPlantas.close();
    await _plantaAnterior.drain();
    _plantaAnterior.close();
  }

  
}

final blocPlanta = BlocPlanta();