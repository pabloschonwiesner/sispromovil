import 'package:rxdart/rxdart.dart';
import 'package:sispromovil/models/FinalizadasModel.dart';
import 'package:sispromovil/repositories/otFinalizadas/OT_Finalizadas_Repository.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository.dart';


class BlocOTFinalizadas {
  static final BlocOTFinalizadas _bloc = new BlocOTFinalizadas._internal();
  BehaviorSubject<FinalizadasModel> _otFinalizadas = BehaviorSubject<FinalizadasModel>();
  BehaviorSubject<FinalizadasModel> _otFinalizadasFiltradas = BehaviorSubject<FinalizadasModel>();
  BehaviorSubject<String> _filtro = BehaviorSubject<String>();
  PlantasRepository _repoPlantas = PlantasRepository();
  OTFinalizadasRepository _repoFinalizadas = OTFinalizadasRepository();

  factory BlocOTFinalizadas() {
    return _bloc;
  }

  BlocOTFinalizadas._internal();

  void initialData() {
    filtro.listen((filtro) => getOtFinalizadas());
    if(_otFinalizadas.value == null) {
      getOtFinalizadas();
    }
  }

  BehaviorSubject<FinalizadasModel> get finalizadasFiltradas => _otFinalizadasFiltradas;
  BehaviorSubject<FinalizadasModel> get finalizadas => _otFinalizadas.stream;
  BehaviorSubject<String> get filtro => _filtro.stream;

  Function(String) get changeFiltro => _filtro.sink.add;

  void getOtFinalizadas({int desde = 1}) async {
    String url;
    _repoPlantas.getPlantaSelect().then((planta) {
      url = '${planta.servidor}/finalizadas?desde=1&cantRegistros=100';
      _repoFinalizadas.fetchAllOTFinalizadas(url).then((ots) {
        _otFinalizadas.sink.add(ots);        
        if(_filtro.value != null && _filtro.value != '' && _otFinalizadas.value.data != null) {
          FinalizadasModel aux = ots;
          aux.data.retainWhere((maquina) {
            return maquina.id == _filtro.value || 
            maquina.cliente.toLowerCase().contains(_filtro.value.toLowerCase()) || 
            maquina.trabajo.toLowerCase().contains(_filtro.value.toLowerCase());});
          _otFinalizadasFiltradas.sink.add(aux);
        } else {
          _otFinalizadasFiltradas.sink.add(ots);
        }
      });
    });    
  }

  void dispose() {
    _otFinalizadas.close();
    _otFinalizadasFiltradas.close();
    _filtro.close();
  }
}

BlocOTFinalizadas blocFinalizadas = BlocOTFinalizadas();