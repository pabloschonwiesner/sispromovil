class EnCursoModel {
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
  int cantBuenosProg;
  String trabajo;
  String estado;
  int codigoMotivo;
  String descripcionMotivo;
  String inicioEstadoActual;
  String inicioProceso;
  double horasDesdeInicio;
  String horaFinalizacion;
  double cantidadBuenos;
  double cantidadMalos;
  double porcAvance;
  String descOperario;
  String descTurno;
  int cantidadHorasProgPrep;
  int cantidadHorasProgProd;
  int cantidadHorasProgPar;
  double tiempoPreUtilizado;
  double tiempoProUtilizado;
  double tiempoParUtilizado;
  int velocidadActual;
  int cS;
  int cR;
  double inicio;

  EnCursoModel(
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
      this.cantBuenosProg,
      this.trabajo,
      this.estado,
      this.codigoMotivo,
      this.descripcionMotivo,
      this.inicioEstadoActual,
      this.inicioProceso,
      this.horasDesdeInicio,
      this.horaFinalizacion,
      this.cantidadBuenos,
      this.cantidadMalos,
      this.porcAvance,
      this.descOperario,
      this.descTurno,
      this.cantidadHorasProgPrep,
      this.cantidadHorasProgProd,
      this.cantidadHorasProgPar,
      this.tiempoPreUtilizado,
      this.tiempoProUtilizado,
      this.tiempoParUtilizado,
      this.velocidadActual,
      this.cS,
      this.cR,
      this.inicio});

  EnCursoModel.fromJson(Map<String, dynamic> json) {
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
    cantBuenosProg = json['Cant_Buenos_Prog'];
    trabajo = json['Trabajo'];
    estado = json['Estado'];
    codigoMotivo = json['CodigoMotivo'];
    descripcionMotivo = json['Descripcion_Motivo'];
    inicioEstadoActual = json['Inicio_Estado_Actual'];
    inicioProceso = json['Inicio_Proceso'];
    horasDesdeInicio = json['Horas_Desde_Inicio'];
    horaFinalizacion = json['Hora_Finalizacion'];
    cantidadBuenos = json['Cantidad_Buenos'];
    cantidadMalos = json['Cantidad_Malos'];
    porcAvance = json['Porc_Avance'];
    descOperario = json['Desc_Operario'];
    descTurno = json['Desc_Turno'];
    cantidadHorasProgPrep = json['CantidadHorasProgPrep'];
    cantidadHorasProgProd = json['CantidadHorasProgProd'];
    cantidadHorasProgPar = json['CantidadHorasProgPar'];
    tiempoPreUtilizado = json['Tiempo_Pre_Utilizado'];
    tiempoProUtilizado = json['Tiempo_Pro_Utilizado'];
    tiempoParUtilizado = json['Tiempo_Par_Utilizado'];
    velocidadActual = json['VelocidadActual'];
    cS = json['CS'];
    cR = json['CR'];
    inicio = json['Inicio'];
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
    data['Cant_Buenos_Prog'] = this.cantBuenosProg;
    data['Trabajo'] = this.trabajo;
    data['Estado'] = this.estado;
    data['CodigoMotivo'] = this.codigoMotivo;
    data['Descripcion_Motivo'] = this.descripcionMotivo;
    data['Inicio_Estado_Actual'] = this.inicioEstadoActual;
    data['Inicio_Proceso'] = this.inicioProceso;
    data['Horas_Desde_Inicio'] = this.horasDesdeInicio;
    data['Hora_Finalizacion'] = this.horaFinalizacion;
    data['Cantidad_Buenos'] = this.cantidadBuenos;
    data['Cantidad_Malos'] = this.cantidadMalos;
    data['Porc_Avance'] = this.porcAvance;
    data['Desc_Operario'] = this.descOperario;
    data['Desc_Turno'] = this.descTurno;
    data['CantidadHorasProgPrep'] = this.cantidadHorasProgPrep;
    data['CantidadHorasProgProd'] = this.cantidadHorasProgProd;
    data['CantidadHorasProgPar'] = this.cantidadHorasProgPar;
    data['Tiempo_Pre_Utilizado'] = this.tiempoPreUtilizado;
    data['Tiempo_Pro_Utilizado'] = this.tiempoProUtilizado;
    data['Tiempo_Par_Utilizado'] = this.tiempoParUtilizado;
    data['VelocidadActual'] = this.velocidadActual;
    data['CS'] = this.cS;
    data['CR'] = this.cR;
    data['Inicio'] = this.inicio;
    return data;
  }
}