class FinalizadasModel {
  int totalRegistros;
  List<Data> data;

  FinalizadasModel({this.totalRegistros, this.data});

  FinalizadasModel.fromJson(Map<String, dynamic> json) {
    totalRegistros = json['totalRegistros'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalRegistros'] = this.totalRegistros;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int codigoInterno;
  String id;
  String subId;
  String cliente;
  String vendedor;
  String trabajo;
  String inicioOt;
  String finOt;

  Data(
      this.codigoInterno,
      {this.id,
      this.subId,
      this.cliente,
      this.vendedor,
      this.trabajo,
      this.inicioOt,
      this.finOt});

  Data.fromJson(Map<String, dynamic> json) {
    codigoInterno = json['codigo_interno'];
    id = json['id'];
    subId = json['sub_id'];
    cliente = json['cliente'];
    vendedor = json['vendedor'];
    trabajo = json['trabajo'];
    inicioOt = json['inicio_ot'];
    finOt = json['fin_ot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo_interno'] = this.codigoInterno;
    data['id'] = this.id;
    data['sub_id'] = this.subId;
    data['cliente'] = this.cliente;
    data['vendedor'] = this.vendedor;
    data['trabajo'] = this.trabajo;
    data['inicio_ot'] = this.inicioOt;
    data['fin_ot'] = this.finOt;
    return data;
  }
}