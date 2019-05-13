import 'package:rxdart/rxdart.dart';
import 'package:sispromovil/repositories/busquedas/Busquedas_Repository.dart';
import 'package:sispromovil/models/BusquedaModel.dart';
import 'package:sispromovil/blocs/ordenesPendientes/BlocOTPendientes.dart';


class BlocBusqueda {
  BlocBusqueda() {
    initialData();
  }

  final _repository = BusquedaRepository();
  List<BusquedaModel> _busquedas;
  BehaviorSubject<int> _id = BehaviorSubject<int>();
  BehaviorSubject<String> _texto = BehaviorSubject<String>();
  BehaviorSubject<List<BusquedaModel>> _listaBusquedas = BehaviorSubject<List<BusquedaModel>>();
  BehaviorSubject<String> _filtro = BehaviorSubject<String>();

  Observable<List<BusquedaModel>> get listaBusquedas => _listaBusquedas.stream;
  Observable<String> get filtro => _filtro.stream;

  changeFiltro(String query) {
    _filtro.sink.add(query);
  }

  void initialData() async {
    llenarHistorialBusqueda();
  }

  void llenarHistorialBusqueda() async {
    _busquedas = await _repository.getBusquedas();
    _listaBusquedas.sink.add(_busquedas);
    _filtro.listen((filtro) {
      blocOTPendientes.changeFiltro(filtro);
    });
  }

  void agregarBusqueda(String query) async {
    _repository.addBusqueda(query);
    llenarHistorialBusqueda();
  }

  void borrarBusqueda(int id) async {
    _repository.deleteBusqueda(id);
    llenarHistorialBusqueda();
  }

  void guardarFiltros(String query) async {
    changeFiltro(query);
    _filtro.listen((data) {
      blocOTPendientes.changeFiltro(data);
    });
  }

  void dispose() async {
    await _id.drain();
    _id.close();
    await _texto.drain();
    _texto.close();
    await _listaBusquedas.drain();
    _listaBusquedas.close();
    await _filtro.drain();
    _filtro.close();
  }
}

final blocBusquedas = BlocBusqueda();