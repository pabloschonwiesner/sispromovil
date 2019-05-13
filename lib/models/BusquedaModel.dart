

class BusquedaModel {
  int id;
  String busqueda;

  BusquedaModel({this.id, this.busqueda});
  factory BusquedaModel.fromJson(Map<String, dynamic> json) => BusquedaModel(
    id: json['id'],
    busqueda: json['busqueda']
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "busqueda": busqueda
  };
}