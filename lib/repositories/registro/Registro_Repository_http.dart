import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:sispromovil/models/RegistroModel.dart';

class RegistroApiProvider {
  Client client = Client();

  Future<RegistroModel> fetchRegistro(String codigo) async {
    String url = 'http://servidor.upsoftware.com.ar:4000/registrar?codigo=$codigo';
    final response = await client.get(url);
    if(response.statusCode == 200) {
      // print(response.body);
      return RegistroModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error en la peticion a la base de datos, fetchRegistro');
    }
  }
}