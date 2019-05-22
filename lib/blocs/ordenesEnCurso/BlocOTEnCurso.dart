import 'package:rxdart/rxdart.dart';
import 'package:sispromovil/models/EnCursoModel.dart';
import 'package:sispromovil/repositories/otEnCurso/OT_EnCurso_Repository.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository.dart';
import 'dart:async';


class BlocOTEnCurso {
  static final BlocOTEnCurso _bloc = new BlocOTEnCurso._internal();
  BehaviorSubject<EnCursoModel> _otEnCurso = BehaviorSubject<EnCursoModel>();
  BehaviorSubject<EnCursoModel> _otEnCursoFiltradas = BehaviorSubject<EnCursoModel>();
  BehaviorSubject<String> _filtro = BehaviorSubject<String>();
  PlantasRepository _repoPlantas = PlantasRepository();
  OTPendientesRepository _repoOtEnCurso = OTPendientesRepository();
  var timer;
  Duration ms = Duration(milliseconds: 1);

  factory BlocOTEnCurso() {
    return _bloc;
  }

  BlocOTEnCurso._internal();

  void initialData() {
    filtro.listen((filtro) => getOtEnCurso());
    if(_otEnCurso.value == null) {
      getOtEnCurso();
    }

    if(timer != null) {
      timer.cancel();
      timer = _iniciarTimer(5000);
    }
  }

  BehaviorSubject<EnCursoModel> get enCursoFiltradas => _otEnCursoFiltradas;
  BehaviorSubject<EnCursoModel> get enCurso => _otEnCurso.stream;
  BehaviorSubject<String> get filtro => _filtro.stream;

  Function(String) get changeFiltro => _filtro.sink.add;

  void getOtEnCurso() async {
    String url;
    timer?.cancel();
    timer = _iniciarTimer(5000);
    _repoPlantas.getPlantaSelect().then((planta) {
      url = '${planta.servidor}/enProceso';
      _repoOtEnCurso.fetchAllOTEnCurso(url).then((ots) {
        _otEnCurso.sink.add(ots);        
        if(_filtro.value != null && _filtro.value != '' && _otEnCurso.value.data != null) {
          EnCursoModel aux = ots;
          aux.data.retainWhere((maquina) {
            return maquina.id == _filtro.value || 
            maquina.descripcionCliente.toLowerCase().contains(_filtro.value.toLowerCase()) || 
            maquina.trabajo.toLowerCase().contains(_filtro.value.toLowerCase());});
          _otEnCursoFiltradas.sink.add(aux);
        } else {
          _otEnCursoFiltradas.sink.add(ots);
        }
      });
    });    
  }

  Timer _iniciarTimer(int milisegundos) {
    var duracion = milisegundos == null ? 30000 : ms * milisegundos;
    return Timer.periodic(duracion, (Timer timer) => getOtEnCurso());
  }

  void dispose() {
    _otEnCurso.close();
    _otEnCursoFiltradas.close();
    _filtro.close();
    timer.cancel();
  }
}

BlocOTEnCurso blocEnCurso = BlocOTEnCurso();