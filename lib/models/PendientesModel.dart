class PendientesModel {
  List<Data> data;

  PendientesModel({this.data});

  PendientesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String codigoInterno;
  String id;
  String subId;
  String cliente;
  String vendedor;
  String trabajo;
  int cantBuenasProg;
  String fechaEntrega;
  String fecha;

  Data(
      {this.codigoInterno,
      this.id,
      this.subId,
      this.cliente,
      this.vendedor,
      this.trabajo,
      this.cantBuenasProg,
      this.fechaEntrega,
      this.fecha});

  Data.fromJson(Map<String, dynamic> json) {
    codigoInterno = json['codigo_interno'];
    id = json['id'];
    subId = json['sub_id'];
    cliente = json['cliente'];
    vendedor = json['vendedor'];
    trabajo = json['trabajo'];
    cantBuenasProg = json['cant_buenas_prog'];
    fechaEntrega = json['fecha_entrega'];
    fecha = json['fecha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo_interno'] = this.codigoInterno;
    data['id'] = this.id;
    data['sub_id'] = this.subId;
    data['cliente'] = this.cliente;
    data['vendedor'] = this.vendedor;
    data['trabajo'] = this.trabajo;
    data['cant_buenas_prog'] = this.cantBuenasProg;
    data['fecha_entrega'] = this.fechaEntrega;
    data['fecha'] = this.fecha;
    return data;
  }
}