class Ot {
  List<Ots> ots;

  Ot({this.ots});

  Ot.fromJson(Map<String, dynamic> json) {
    if (json['ots'] != null) {
      ots = new List<Ots>();
      json['ots'].forEach((v) {
        ots.add(new Ots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ots != null) {
      data['ots'] = this.ots.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ots {
  String id;
  String subId;
  String fechaOT;
  String cliente;
  String vendedor;
  String trabajo;
  int cantidadProducto;
  String fechaEntrega;

  Ots(
      {this.id,
      this.subId,
      this.fechaOT,
      this.cliente,
      this.vendedor,
      this.trabajo,
      this.cantidadProducto,
      this.fechaEntrega
  });

  Ots.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    subId = json['sub_id'].toString();
    fechaOT = json['fecha_ot'];
    cliente = json['cliente'].toString();
    vendedor = json['vendedor'].toString();
    trabajo = json['trabajo'].toString();
    cantidadProducto = json['cantidad_producto'];
    fechaEntrega = json['fecha_entrega'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ot = new Map<String, dynamic>();
    ot['id'] = this.id;
    ot['sub_id'] = this.subId;
    ot['fecha_ot'] = this.fechaOT;
    ot['cliente'] = this.cliente;
    ot['vendedor'] = this.vendedor;
    ot['trabajo'] = this.trabajo;
    ot['cantidad_producto'] = this.cantidadProducto;
    ot['fecha_entrega'] = this.fechaEntrega;
    return ot;
  }
}