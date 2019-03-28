class PendientesPlanificadasModel {
  int totalRegistros;
  List<Data> data;

  PendientesPlanificadasModel({this.totalRegistros, this.data});

  PendientesPlanificadasModel.fromJson(Map<String, dynamic> json) {
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
  String maquina;
  List<Ots> ots;

  Data({this.maquina, this.ots});

  Data.fromJson(Map<String, dynamic> json) {
    maquina = json['maquina'];
    if (json['ots'] != null) {
      ots = new List<Ots>();
      json['ots'].forEach((v) {
        ots.add(new Ots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maquina'] = this.maquina;
    if (this.ots != null) {
      data['ots'] = this.ots.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ots {
  String fechaOT;
  String id;
  String subId;
  int codigoTablero;
  String cliente;
  String vendedor;
  String trabajo;
  int cantidadProducto;
  String maquina;
  double cantBuenasProg;
  String fechaEntrega;
  String fechaInicio;
  String fechaFin;
  double horasProgPrep;
  double horasProgProd;
  double horasProgPar;
  double horasTotales;

  Ots(
      {this.id,
      this.fechaOT,
      this.subId,
      this.codigoTablero,
      this.cliente,
      this.vendedor,
      this.trabajo,
      this.cantidadProducto,
      this.maquina,
      this.cantBuenasProg,
      this.fechaEntrega,
      this.fechaInicio,
      this.fechaFin,
      this.horasProgPrep,
      this.horasProgProd,
      this.horasProgPar,
      this.horasTotales});

  Ots.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    fechaOT = json['fecha_ot'];
    subId = json['sub_id'].toString();
    codigoTablero = json['codigo_tablero'];
    cliente = json['cliente'].toString();
    vendedor = json['vendedor'].toString();
    trabajo = json['trabajo'].toString();
    cantidadProducto = json['cantidad_producto'];
    maquina = json['maquina'].toString();
    cantBuenasProg = double.parse(json['cant_buenas_prog'].toString());
    fechaEntrega = json['fecha_entrega'].toString();
    fechaInicio = json['fecha_inicio'].toString();
    fechaFin = json['fecha_fin'].toString();
    horasProgPrep = double.parse(json['horas_prog_prep'].toString());
    horasProgProd = double.parse(json['horas_prog_prod'].toString());
    horasProgPar = double.parse(json['horas_prog_par'].toString());
    horasTotales = double.parse(json['horas_totales'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fecha_ot'] = this.fechaOT;
    data['sub_id'] = this.subId;
    data['codigo_tablero'] = this.codigoTablero;
    data['cliente'] = this.cliente;
    data['vendedor'] = this.vendedor;
    data['trabajo'] = this.trabajo;
    data['cantidad_producto'] = this.cantidadProducto;
    data['maquina'] = this.maquina;
    data['cant_buenas_prog'] = this.cantBuenasProg;
    data['fecha_entrega'] = this.fechaEntrega;
    data['fecha_inicio'] = this.fechaInicio;
    data['fecha_fin'] = this.fechaFin;
    data['horas_prog_prep'] = this.horasProgPrep;
    data['horas_prog_prod'] = this.horasProgProd;
    data['horas_prog_par'] = this.horasProgPar;
    data['horas_totales'] = this.horasTotales;
    return data;
  }
}