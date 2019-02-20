class FinalizadasModel {
  String codigoInterno;
  int codigo;
  String iD;
  String subID;
  String codigoCliente;
  String descripcionCliente;
  String codigoVendedor;
  String descripcionVendedor;
  String descSolapa;
  String descRecurso;
  String trabajo;
  String fechaInicioOT;
  String fechaFinOT;
  String horaFinalizacion;
  int cantBuenasProg;
  int cantMalasProg;
  int cantidadBuenos;
  int cantidadMalos;
  int difCantBuenos;
  int difCantMalos;
  int porcCompletado;
  int cantidadHorasProgPrep;
  int cantidadHorasProgProd;
  int cantidadHorasProgPar;
  int tiempoPreUtilizado;
  int tiempoProUtilizado;
  int tiempoParUtilizado;
  String usuario;
  int codigoSolapa;
  int codigoRenglon;
  double horaInicio;

  FinalizadasModel(
      {this.codigoInterno,
      this.codigo,
      this.iD,
      this.subID,
      this.codigoCliente,
      this.descripcionCliente,
      this.codigoVendedor,
      this.descripcionVendedor,
      this.descSolapa,
      this.descRecurso,
      this.trabajo,
      this.fechaInicioOT,
      this.fechaFinOT,
      this.horaFinalizacion,
      this.cantBuenasProg,
      this.cantMalasProg,
      this.cantidadBuenos,
      this.cantidadMalos,
      this.difCantBuenos,
      this.difCantMalos,
      this.porcCompletado,
      this.cantidadHorasProgPrep,
      this.cantidadHorasProgProd,
      this.cantidadHorasProgPar,
      this.tiempoPreUtilizado,
      this.tiempoProUtilizado,
      this.tiempoParUtilizado,
      this.usuario,
      this.codigoSolapa,
      this.codigoRenglon,
      this.horaInicio});

  FinalizadasModel.fromJson(Map<String, dynamic> json) {
    codigoInterno = json['Codigo_Interno'];
    codigo = json['Codigo'];
    iD = json['ID'];
    subID = json['SubID'];
    codigoCliente = json['CodigoCliente'];
    descripcionCliente = json['DescripcionCliente'];
    codigoVendedor = json['CodigoVendedor'];
    descripcionVendedor = json['DescripcionVendedor'];
    descSolapa = json['Desc_Solapa'];
    descRecurso = json['Desc_Recurso'];
    trabajo = json['Trabajo'];
    fechaInicioOT = json['Fecha_Inicio_OT'];
    fechaFinOT = json['Fecha_Fin_OT'];
    horaFinalizacion = json['Hora_Finalizacion'];
    cantBuenasProg = json['Cant_Buenas_Prog'];
    cantMalasProg = json['Cant_Malas_Prog'];
    cantidadBuenos = json['Cantidad_Buenos'];
    cantidadMalos = json['Cantidad_Malos'];
    difCantBuenos = json['Dif_Cant_Buenos'];
    difCantMalos = json['Dif_Cant_Malos'];
    porcCompletado = json['Porc_Completado'];
    cantidadHorasProgPrep = json['CantidadHorasProgPrep'];
    cantidadHorasProgProd = json['CantidadHorasProgProd'];
    cantidadHorasProgPar = json['CantidadHorasProgPar'];
    tiempoPreUtilizado = json['Tiempo_Pre_Utilizado'];
    tiempoProUtilizado = json['Tiempo_Pro_Utilizado'];
    tiempoParUtilizado = json['Tiempo_Par_Utilizado'];
    usuario = json['Usuario'];
    codigoSolapa = json['CodigoSolapa'];
    codigoRenglon = json['CodigoRenglon'];
    horaInicio = json['HoraInicio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Codigo_Interno'] = this.codigoInterno;
    data['Codigo'] = this.codigo;
    data['ID'] = this.iD;
    data['SubID'] = this.subID;
    data['CodigoCliente'] = this.codigoCliente;
    data['DescripcionCliente'] = this.descripcionCliente;
    data['CodigoVendedor'] = this.codigoVendedor;
    data['DescripcionVendedor'] = this.descripcionVendedor;
    data['Desc_Solapa'] = this.descSolapa;
    data['Desc_Recurso'] = this.descRecurso;
    data['Trabajo'] = this.trabajo;
    data['Fecha_Inicio_OT'] = this.fechaInicioOT;
    data['Fecha_Fin_OT'] = this.fechaFinOT;
    data['Hora_Finalizacion'] = this.horaFinalizacion;
    data['Cant_Buenas_Prog'] = this.cantBuenasProg;
    data['Cant_Malas_Prog'] = this.cantMalasProg;
    data['Cantidad_Buenos'] = this.cantidadBuenos;
    data['Cantidad_Malos'] = this.cantidadMalos;
    data['Dif_Cant_Buenos'] = this.difCantBuenos;
    data['Dif_Cant_Malos'] = this.difCantMalos;
    data['Porc_Completado'] = this.porcCompletado;
    data['CantidadHorasProgPrep'] = this.cantidadHorasProgPrep;
    data['CantidadHorasProgProd'] = this.cantidadHorasProgProd;
    data['CantidadHorasProgPar'] = this.cantidadHorasProgPar;
    data['Tiempo_Pre_Utilizado'] = this.tiempoPreUtilizado;
    data['Tiempo_Pro_Utilizado'] = this.tiempoProUtilizado;
    data['Tiempo_Par_Utilizado'] = this.tiempoParUtilizado;
    data['Usuario'] = this.usuario;
    data['CodigoSolapa'] = this.codigoSolapa;
    data['CodigoRenglon'] = this.codigoRenglon;
    data['HoraInicio'] = this.horaInicio;
    return data;
  }
}