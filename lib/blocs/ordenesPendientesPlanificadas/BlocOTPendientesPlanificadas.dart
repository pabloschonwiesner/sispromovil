import 'package:rxdart/rxdart.dart';
import 'package:sispromovil/models/PendientesPlanificadasModel.dart';
import 'package:sispromovil/repositories/otPendientesPlanificadas/OT_Pendientes_Planificadas_Repository.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository.dart';


class BlocOTPendientesPlanificadas {
  static final BlocOTPendientesPlanificadas _bloc = new BlocOTPendientesPlanificadas._internal();
  BehaviorSubject<PendientesPlanificadasModel> _otPendientesPlanificadas = BehaviorSubject<PendientesPlanificadasModel>();
  BehaviorSubject<PendientesPlanificadasModel> _otPendientesPlanificadasFiltradas = BehaviorSubject<PendientesPlanificadasModel>();
  BehaviorSubject<String> _filtro = BehaviorSubject<String>();
  PlantasRepository _repoPlantas = PlantasRepository();
  OTPendientesPlanificadasRepository _repoOtPendientesPlanificadas = OTPendientesPlanificadasRepository();

  factory BlocOTPendientesPlanificadas() {
    return _bloc;
  }

  BlocOTPendientesPlanificadas._internal();

  void initialData() {
    filtro.listen((filtro) => getOtPendientesPlanificadas());
    if(_otPendientesPlanificadas.value == null) {
      getOtPendientesPlanificadas();
    }
  }

  BehaviorSubject<PendientesPlanificadasModel> get pendientesFiltradas => _otPendientesPlanificadasFiltradas;
  BehaviorSubject<PendientesPlanificadasModel> get pendientes => _otPendientesPlanificadas.stream;
  BehaviorSubject<String> get filtro => _filtro.stream;

  Function(String) get changeFiltro => _filtro.sink.add;

  void getOtPendientesPlanificadas() async {
    String url;

    _repoPlantas.getPlantaSelect().then((planta) {
      url = '${planta.servidor}/pendientesPlanificadas';
      _repoOtPendientesPlanificadas.fetchAllOTPendientesPlanificadas(url).then((ots) {
        _otPendientesPlanificadas.sink.add(ots);   
        if(_filtro.value != null && _filtro.value != '' && ots.data.isNotEmpty) {
          PendientesPlanificadasModel aux = ots;     
          ots.data.map((maquina) {
            if(maquina.ots.isNotEmpty) {
              maquina.ots.retainWhere((ot) {
                return  ot.id == _filtro.value || 
                        ot.cliente.toLowerCase().contains(_filtro.value.toLowerCase()) || 
                        ot.trabajo.toLowerCase().contains(_filtro.value.toLowerCase());
              });
            }
          }).toList();
          ots.data.retainWhere((maquina) {
            return maquina.ots.isNotEmpty;
          });
          _otPendientesPlanificadasFiltradas.sink.add(aux);
        } else {
          _otPendientesPlanificadasFiltradas.sink.add(ots);
        }
      });
    });    
  }

  void dispose() {
    _otPendientesPlanificadas.close();
    _otPendientesPlanificadasFiltradas.close();
    _filtro.close();
  }
}

BlocOTPendientesPlanificadas blocPendientesPlanificadas = BlocOTPendientesPlanificadas();