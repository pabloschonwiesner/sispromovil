import 'package:rxdart/rxdart.dart';
import 'package:sispromovil/models/NotificacionesModel.dart';
import 'package:sispromovil/repositories/notificaciones/Notificaciones_Repository.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository.dart';


class BlocNotificaciones {
  static final BlocNotificaciones _bloc = new BlocNotificaciones._internal();
  BehaviorSubject<NotificacionesModel> _notificaciones = BehaviorSubject<NotificacionesModel>();
  BehaviorSubject<int> _cantidadNotificaciones = BehaviorSubject<int>.seeded(0);
  PlantasRepository _repoPlantas = PlantasRepository();
  NotificacionesRepository _repoNotificaciones = NotificacionesRepository();

  factory BlocNotificaciones() {
    return _bloc;
  }

  BlocNotificaciones._internal();

  void initialData() async {
    await getNotificaciones();
  }

  BehaviorSubject<NotificacionesModel> get notificaciones => _notificaciones.stream;
  BehaviorSubject<int> get cantidadNotificaciones => _cantidadNotificaciones.stream;

  void getNotificaciones() async {
    String url;
    _cantidadNotificaciones.sink.add(0);
    await _repoPlantas.getPlantaSelect().then((planta) {
      url = '${planta.servidor}/notificaciones';
      _repoNotificaciones.fetchAllNotificaciones(url).then((ots) {
        _notificaciones.sink.add(ots); 
        _cantidadNotificaciones.sink.add(notificaciones.value.data.length);
      });
    });    
  }

  void marcar(String codigo) async {
    String url;
    await _repoPlantas.getPlantaSelect().then((planta) {
      url = '${planta.servidor}/notificaciones';
      _repoNotificaciones.marcar(url, codigo).then((ots) {
        getNotificaciones();
      });
    });  
  }

  void dispose() {
    _notificaciones.close();
    _cantidadNotificaciones.close();
  }
}

BlocNotificaciones blocNotificaciones = BlocNotificaciones();