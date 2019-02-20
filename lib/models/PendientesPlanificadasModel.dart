class PendientesPlanificadasModel {
  String codigoInterno;
  String iD;
  String subID;
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

  PendientesPlanificadasModel(
      {this.codigoInterno,
      this.iD,
      this.subID,
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

  PendientesPlanificadasModel.fromJson(Map<String, dynamic> json) {
    codigoInterno = json['Codigo_Interno'];
    iD = json['ID'];
    subID = json['SubID'];
    codigoTablero = json['CodigoTablero'];
    cliente = json['Cliente'];
    vendedor = json['Vendedor'];
    trabajo = json['Trabajo'];
    maquina = json['Maquina'];
    cantBuenasProg = json['Cant_Buenas_Prog'];
    fechaEntrega = json['Fecha_Entrega'];
    fechaInicio = json['FechaInicio'];
    fechaFin = json['FechaFin'];
    horasProgPrep = json['HorasProgPrep'];
    horasProgProd = json['HorasProgProd'];
    horasProgPar = json['HorasProgPar'];
    horasTotales = json['HorasTotales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Codigo_Interno'] = this.codigoInterno;
    data['ID'] = this.iD;
    data['SubID'] = this.subID;
    data['CodigoTablero'] = this.codigoTablero;
    data['Cliente'] = this.cliente;
    data['Vendedor'] = this.vendedor;
    data['Trabajo'] = this.trabajo;
    data['Maquina'] = this.maquina;
    data['Cant_Buenas_Prog'] = this.cantBuenasProg;
    data['Fecha_Entrega'] = this.fechaEntrega;
    data['FechaInicio'] = this.fechaInicio;
    data['FechaFin'] = this.fechaFin;
    data['HorasProgPrep'] = this.horasProgPrep;
    data['HorasProgProd'] = this.horasProgProd;
    data['HorasProgPar'] = this.horasProgPar;
    data['HorasTotales'] = this.horasTotales;
    return data;
  }
}