import 'package:flutter/material.dart';
export 'package:provider/provider.dart';
import 'package:sispromovil/models/NotificacionesModel.dart';
import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sispromovil/repositories/notificaciones/Notificaciones_Repository.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository.dart';

class NotificacionesProvider with ChangeNotifier {
  NotificacionesModel _notificaciones = NotificacionesModel();
  NotificacionesRepository _repoNotificaciones = NotificacionesRepository();
  PlantasRepository _repoPlantas = PlantasRepository();
  PlantaModel _plantaActual;
  bool _isLoading = false;
  bool _hasData = false;

  NotificacionesProvider() {
    getNotificacionesAPI();
  }

  Future<void> getNotificacionesAPI() async {
    setIsLoading(true);
    _plantaActual = await _repoPlantas.getPlantaSelect();
    setNotificaciones(await _repoNotificaciones.fetchAllNotificaciones(_plantaActual.servidor + '/notificaciones'));
    setIsLoading(false);
  }

  NotificacionesModel get getNotificaciones => _notificaciones;
  int get cantNotificaciones => _notificaciones.data?.length ?? 0;
  bool get isLoading => _isLoading;
  bool get hasData => _hasData;

  void setNotificaciones(NotificacionesModel notificacion) {
    _notificaciones = notificacion;
    if(cantNotificaciones > 0) {
      setHasData(true);
    } else {
      setHasData(false);
    }

    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setHasData(bool hasData) {
    _hasData = hasData;
    notifyListeners();
  }
}