import 'package:rxdart/rxdart.dart';
import 'package:sispromovil/models/PendientesModel.dart';
import 'package:sispromovil/repositories/otPendientes/OT_Pendientes_Repository.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository.dart';


class BlocOTPendientes {
  static final BlocOTPendientes _bloc = new BlocOTPendientes._internal();
  BehaviorSubject<PendientesModel> _otPendientes = BehaviorSubject<PendientesModel>();
  BehaviorSubject<PendientesModel> _otPendientesFiltradas = BehaviorSubject<PendientesModel>();
  BehaviorSubject<String> _filtro = BehaviorSubject<String>();
  PlantasRepository _repoPlantas = PlantasRepository();
  OTPendientesRepository _repoOtPendientes = OTPendientesRepository();

  factory BlocOTPendientes() {
    return _bloc;
  }

  BlocOTPendientes._internal();

  void initialData() {
    
    filtro.listen((filtro) => getOtPendientes());
    if(_otPendientes.value == null)
    getOtPendientes();
  }

  BehaviorSubject<PendientesModel> get pendientesFiltradas => _otPendientesFiltradas;
  BehaviorSubject<PendientesModel> get pendientes => _otPendientes.stream;
  BehaviorSubject<String> get filtro => _filtro.stream;

  Function(String) get changeFiltro => _filtro.sink.add;

  void getOtPendientes({int desde = 1 }) async {
    String url;
    _otPendientes.value = null;
    _repoPlantas.getPlantaSelect().then((planta) {
      url = '${planta.servidor}/pendientes?desde=$desde&cantRegistros=300';
      _repoOtPendientes.fetchAllOTPendientes(url).then((ots) {
        _otPendientes.sink.add(ots);        
        if(_filtro.value != null && _filtro.value != '') {
          PendientesModel aux = ots;
          aux.data = _otPendientes.value.data.where((ot) => 
            ot.id == _filtro.value || 
            ot.cliente.toLowerCase().contains(_filtro.value.toLowerCase()) || 
            ot.trabajo.toLowerCase().contains(_filtro.value.toLowerCase())).toList();
          _otPendientesFiltradas.sink.add(aux);
        } else {
          _otPendientesFiltradas.sink.add(ots);
        }
      });
    });    
  }

  void dispose() {
    _otPendientes.close();
    _otPendientesFiltradas.close();
    _filtro.close();
  }
}

BlocOTPendientes blocPendientes = BlocOTPendientes();