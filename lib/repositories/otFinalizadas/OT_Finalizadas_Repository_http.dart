import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:sispromovil/models/FinalizadasModel.dart';

class OTFinalizadasApiProvider {
  Client client = Client();

  Future<FinalizadasModel> fetchOTFinalizadas(String url) async {
    final response = await client.get(url);
    if(response.statusCode == 200) {
      // print(response.body);
      return FinalizadasModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error en la peticion a la base de datos, fetchOTFinalizadas');
    }
  }
}