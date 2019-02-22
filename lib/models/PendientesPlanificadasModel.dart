class PendientesPlanificadasModel {
  List<Data> data;

  PendientesPlanificadasModel({this.data});

  PendientesPlanificadasModel.fromJson(Map<String, dynamic> json) {
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
  int codigoTablero;
  String cliente;
  String vendedor;
  String trabajo;
  String maquina;
  int cantBuenasProg;
  String fechaEntrega;
  String fechaInicio;
  String fechaFin;
  double horasProgPrep;
  double horasProgProd;
  int horasProgPar;
  double horasTotales;

  Data(
      {this.codigoInterno,
      this.id,
      this.subId,
      this.codigoTablero,
      this.cliente,
      this.vendedor,
      this.trabajo,
      this.maquina,
      this.cantBuenasProg,
      this.fechaEntrega,
      this.fechaInicio,
      this.fechaFin,
      this.horasProgPrep,
      this.horasProgProd,
      this.horasProgPar,
      this.horasTotales});

  Data.fromJson(Map<String, dynamic> json) {
    codigoInterno = json['codigo_interno'];
    id = json['id'];
    subId = json['sub_id'];
    codigoTablero = json['codigo_tablero'];
    cliente = json['cliente'];
    vendedor = json['vendedor'];
    trabajo = json['trabajo'];
    maquina = json['maquina'];
    cantBuenasProg = json['cant_buenas_prog'];
    fechaEntrega = json['fecha_entrega'];
    fechaInicio = json['fecha_inicio'];
    fechaFin = json['fecha_fin'];
    horasProgPrep = json['horas_prog_prep'];
    horasProgProd = json['horas_prog_prod'];
    horasProgPar = json['horas_prog_par'];
    horasTotales = json['horas_totales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo_interno'] = this.codigoInterno;
    data['id'] = this.id;
    data['sub_id'] = this.subId;
    data['codigo_tablero'] = this.codigoTablero;
    data['cliente'] = this.cliente;
    data['vendedor'] = this.vendedor;
    data['trabajo'] = this.trabajo;
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