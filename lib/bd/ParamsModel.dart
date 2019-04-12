import 'dart:convert';

class ParamsModel {
  int id;
  String planta;
  String codigo;
  String servidor;
  int puerto;
  int seleccionada;
  
  ParamsModel({this.id, this.planta, this.codigo, this.servidor, this.puerto, this.seleccionada});

  factory ParamsModel.fromMap(Map<String, dynamic> json) => ParamsModel(
    id: json['id'],
    planta: json['planta'],
    codigo: json['codigo'],
    servidor: json['servidor'],
    puerto: json['puerto'],
    seleccionada: json['seleccionada']
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "planta": planta,
    "codigo": codigo,
    "servidor": servidor,
    "puerto": puerto,
    "seleccionada": seleccionada
  };

  ParamsModel paramsFromJson(String str) {
    final jsonData = json.decode(str);
    return ParamsModel.fromMap(jsonData);
  }

  String paramsToJson(ParamsModel data) {
    final result = data.toMap();
    return json.encode(result);
  }

}
