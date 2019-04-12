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
  String fechaOT;
  String cliente;
  String vendedor;
  String trabajo;
  int cantidadProducto;
  String fechaEntrega;
  String inicioOt;
  String finOt;

  Data({this.codigoInterno,
      this.id,
      this.subId,
      this.fechaOT,
      this.cliente,
      this.vendedor,
      this.trabajo,
      this.cantidadProducto,
      this.fechaEntrega,
      this.inicioOt,
      this.finOt});

  Data.fromJson(Map<String, dynamic> json) {
    codigoInterno = json['codigo_interno'];
    id = json['id'];
    subId = json['sub_id'];
    fechaOT = json['fecha_ot'];
    cliente = json['cliente'];
    vendedor = json['vendedor'];
    trabajo = json['trabajo'];
    cantidadProducto = json['cantidad_producto'];
    fechaEntrega = json['fecha_entrega'];
    inicioOt = json['inicio_ot'];
    finOt = json['fin_ot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo_interno'] = this.codigoInterno;
    data['id'] = this.id;
    data['sub_id'] = this.subId;
    data['fecha_ot'] = this.fechaOT;
    data['cliente'] = this.cliente;
    data['vendedor'] = this.vendedor;
    data['trabajo'] = this.trabajo;
    data['cantidad_producto'] = this.cantidadProducto;
    data['fecha_entrega'] = this.fechaEntrega;
    data['inicio_ot'] = this.inicioOt;
    data['fin_ot'] = this.finOt;
    return data;
  }
}