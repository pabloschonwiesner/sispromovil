import 'package:rxdart/rxdart.dart';
import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository.dart';
import 'package:sispromovil/blocs/ordenesPendientes/BlocOTPendientes.dart';
import 'package:sispromovil/blocs/ordenesPendientesPlanificadas/BlocOTPendientesPlanificadas.dart';
import 'package:sispromovil/blocs/ordenesEnCurso/BlocOTEnCurso.dart';
import 'package:sispromovil/blocs/ordenesFinalizadas/BlocOTFinalizadas.dart';
import 'package:sispromovil/blocs/notificaciones/BlocNotificaciones.dart';

class BlocPlanta {
  BlocPlanta() {
    initialData();
  }

  final _repository = PlantasRepository();
  final _id = BehaviorSubject<int>();
  final _planta = BehaviorSubject<String>();
  final _codigo = BehaviorSubject<String>();
  final _servidor = BehaviorSubject<String>();
  final _seleccionada = BehaviorSubject<int>();
  final _listaPlantas = BehaviorSubject<List<PlantaModel>>();
  final _filtro = BehaviorSubject<String>();

  List<PlantaModel> _plantas;

  //cambiar datos
  Function(int) get changeId => _id.sink.add;
  Function(String) get changePlanta => _planta.sink.add;
  Function(String) get changeCodigo => _codigo.sink.add;
  Function(String) get changeServidor => _servidor.sink.add;
  Function(int) get changeSeleccionada => _seleccionada.sink.add;
  Function(String) get changeFiltro => _filtro.sink.add;
  
  //obtener datos
  Observable<int> get id => _id.stream;
  Observable<String> get planta => _planta.stream;
  Observable<String> get codigo => _codigo.stream;
  Observable<String> get servidor => _servidor.stream;
  Observable<int> get seleccionada => _seleccionada.stream;
  Observable<List<PlantaModel>> get listaPlantas => _listaPlantas.stream;
  Observable<String> get filtro => _filtro.stream;


  void initialData() async {
    await llenarListaPlantas();
  }

  void llenarListaPlantas() async {
    _plantas = await _repository.getPlantas();
    for(var i = 0; i < _plantas.length; i++) {
      if(_plantas[i].seleccionada == 1) {
        changeId(_plantas[i].id);
        changePlanta(_plantas[i].planta);
        changeCodigo(_plantas[i].codigo);
        changeServidor(_plantas[i].servidor);
        changeSeleccionada(_plantas[i].seleccionada);
      }
    }
    if(_plantas.length>1) {
      _plantas.removeAt(0);
    }
    _listaPlantas.sink.add(_plantas);
  }

  void seleccionarPlanta(int id) async {
    await _repository.selectPlanta(id);
    await llenarListaPlantas();
    blocPendientes.getOtPendientes();
    blocPendientes.changeFiltro('');
    blocPendientesPlanificadas.changeFiltro('');
    blocPendientesPlanificadas.getOtPendientesPlanificadas();
    blocEnCurso.changeFiltro('');
    blocEnCurso.getOtEnCurso();
    blocFinalizadas.changeFiltro('');
    blocFinalizadas.getOtFinalizadas();
    blocNotificaciones.getNotificaciones();
  }

  void agregarPlanta(PlantaModel planta) async {
    await _repository.addPlanta(planta);
    await llenarListaPlantas();
  }

  void actualizarPlanta(PlantaModel planta) async {
    await _repository.updatePlanta(planta);
    await llenarListaPlantas();
  }
  
  void deletePlanta(PlantaModel planta) async {
    await _repository.deletePlanta(planta);
    await llenarListaPlantas();
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
    await _seleccionada.drain();
    _seleccionada.close();
    await _listaPlantas.drain();
    _listaPlantas.close();
    await _filtro.drain();
    _filtro.close();
  }

  
}

final blocPlanta = BlocPlanta();