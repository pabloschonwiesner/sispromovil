import 'package:sispromovil/repositories/notificaciones/Notificaciones_Repository_http.dart';
import 'package:sispromovil/models/NotificacionesModel.dart';

class NotificacionesRepository {

  NotificacionesApiProvider provider = NotificacionesApiProvider();

  Future<NotificacionesModel> fetchAllNotificaciones(String url) => provider.fetchNotificaciones(url);

  Future marcar(String url, String codigo) => provider.marcarNotificacion(url, codigo);

  Future desmarcarTodas(String url) => provider.desmarcarTodas(url);
}