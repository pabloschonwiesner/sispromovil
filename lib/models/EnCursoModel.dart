class EnCursoModel {
  List<Data> data;

  EnCursoModel({this.data});

  EnCursoModel.fromJson(Map<String, dynamic> json) {
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
  int codigo;
  String id;
  String subId;
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
  int cantidadHoraProgPar;
  double tiempoPreUtilizado;
  double tiempoProUtilizado;
  double tiempoParUtilizado;
  int velocidadActual;
  int cs;
  int cr;
  double inicio;

  Data(
      {this.codigoInterno,
      this.codigo,
      this.id,
      this.subId,
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
      this.cantidadHoraProgPar,
      this.tiempoPreUtilizado,
      this.tiempoProUtilizado,
      this.tiempoParUtilizado,
      this.velocidadActual,
      this.cs,
      this.cr,
      this.inicio});

  Data.fromJson(Map<String, dynamic> json) {
    codigoInterno = json['codigo_interno'];
    codigo = json['codigo'];
    id = json['id'];
    subId = json['sub_id'];
    codigoCliente = json['codigo_cliente'];
    descripcionCliente = json['descripcion_cliente'];
    codigoVendedor = json['codigo_vendedor'];
    descripcionVendedor = json['descripcion_vendedor'];
    descSolapa = json['desc_solapa'];
    descRecurso = json['desc_recurso'];
    cantBuenosProg = json['cant_buenos_prog'];
    trabajo = json['trabajo'];
    estado = json['estado'];
    codigoMotivo = json['codigo_motivo'];
    descripcionMotivo = json['descripcion_motivo'];
    inicioEstadoActual = json['inicio_estado_actual'];
    inicioProceso = json['inicio_proceso'];
    horasDesdeInicio = json['horas_desde_inicio'];
    horaFinalizacion = json['hora_finalizacion'];
    cantidadBuenos = json['cantidad_buenos'];
    cantidadMalos = json['cantidad_malos'];
    porcAvance = json['porc_avance'];
    descOperario = json['desc_operario'];
    descTurno = json['desc_turno'];
    cantidadHorasProgPrep = json['cantidadHoras_prog_prep'];
    cantidadHorasProgProd = json['cantidadHoras_prog_prod'];
    cantidadHoraProgPar = json['cantidadHora_prog_par'];
    tiempoPreUtilizado = json['tiempo_pre_utilizado'];
    tiempoProUtilizado = json['tiempo_pro_utilizado'];
    tiempoParUtilizado = json['tiempo_par_utilizado'];
    velocidadActual = json['velocidad_actual'];
    cs = json['cs'];
    cr = json['cr'];
    inicio = json['inicio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo_interno'] = this.codigoInterno;
    data['codigo'] = this.codigo;
    data['id'] = this.id;
    data['sub_id'] = this.subId;
    data['codigo_cliente'] = this.codigoCliente;
    data['descripcion_cliente'] = this.descripcionCliente;
    data['codigo_vendedor'] = this.codigoVendedor;
    data['descripcion_vendedor'] = this.descripcionVendedor;
    data['desc_solapa'] = this.descSolapa;
    data['desc_recurso'] = this.descRecurso;
    data['cant_buenos_prog'] = this.cantBuenosProg;
    data['trabajo'] = this.trabajo;
    data['estado'] = this.estado;
    data['codigo_motivo'] = this.codigoMotivo;
    data['descripcion_motivo'] = this.descripcionMotivo;
    data['inicio_estado_actual'] = this.inicioEstadoActual;
    data['inicio_proceso'] = this.inicioProceso;
    data['horas_desde_inicio'] = this.horasDesdeInicio;
    data['hora_finalizacion'] = this.horaFinalizacion;
    data['cantidad_buenos'] = this.cantidadBuenos;
    data['cantidad_malos'] = this.cantidadMalos;
    data['porc_avance'] = this.porcAvance;
    data['desc_operario'] = this.descOperario;
    data['desc_turno'] = this.descTurno;
    data['cantidadHoras_prog_prep'] = this.cantidadHorasProgPrep;
    data['cantidadHoras_prog_prod'] = this.cantidadHorasProgProd;
    data['cantidadHora_prog_par'] = this.cantidadHoraProgPar;
    data['tiempo_pre_utilizado'] = this.tiempoPreUtilizado;
    data['tiempo_pro_utilizado'] = this.tiempoProUtilizado;
    data['tiempo_par_utilizado'] = this.tiempoParUtilizado;
    data['velocidad_actual'] = this.velocidadActual;
    data['cs'] = this.cs;
    data['cr'] = this.cr;
    data['inicio'] = this.inicio;
    return data;
  }
}