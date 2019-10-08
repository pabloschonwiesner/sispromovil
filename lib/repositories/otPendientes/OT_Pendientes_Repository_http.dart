import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:sispromovil/models/PendientesModel.dart';

class OTPendientesApiProvider {
  Client client = Client();

  Future<PendientesModel> fetchOTPendientes(String url) async {
    final response = await client.get(url);
    if(response.statusCode == 200) {
      // print(response.body);
      return PendientesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error en la peticion a la base de datos, fetchOPPendientes');
    }
  }

  Future<PendientesModel> fetchOTPendientesFiltradas(String url) async {
    final response = await client.get(url);
    if(response.statusCode == 200) {
      // print(response.body);
      return PendientesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error en la peticion a la base de datos, fetchOPPendientes');
    }
  }
}