import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sispromovil/models/NotificacionesModel.dart';

class NotificacionesApiProvider {
  // Client client = Client();

  Future<NotificacionesModel> fetchNotificaciones(String url) async {
    final response = await http.get(url);
    if(response.statusCode == 200) {
      // print(response.body);
      return NotificacionesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error en la peticion a la base de datos, fetchOPPendientes');
    }
  }

  Future marcarNotificacion(String url, String codigo) async {
    final response = await http.post(url, headers: {"Content-Type": "application/x-www-form-urlencoded"}, body: {'codigo': codigo} );
    return response.body;
  }

  Future desmarcarTodas(String url) async {
    final response = await http.get(url);
    return response.body;
  }
}