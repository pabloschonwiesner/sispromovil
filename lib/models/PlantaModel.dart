import 'dart:convert';

class PlantaModel {
  int id;
  String planta;
  String codigo;
  String servidor;
  int seleccionada;
  
  PlantaModel({this.id, this.planta, this.codigo, this.servidor,  this.seleccionada});

  factory PlantaModel.fromMap(Map<String, dynamic> json) => PlantaModel(
    id: json['id'],
    planta: json['planta'],
    codigo: json['codigo'],
    servidor: json['servidor'],
    seleccionada: json['seleccionada']
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "planta": planta,
    "codigo": codigo,
    "servidor": servidor,
    "seleccionada": seleccionada
  };

  PlantaModel paramsFromJson(String str) {
    final jsonData = json.decode(str);
    return PlantaModel.fromMap(jsonData);
  }

  String paramsToJson(PlantaModel data) {
    final result = data.toMap();
    return json.encode(result);
  }

}
