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
  int codigoInterno;
  int codigo;
  String id;
  String subId;
  String codigoCliente;
  String descripcionCliente;
  String codigoVendedor;
  String descripcionVendedor;
  String descSolapa;
  String descRecurso;
  double cantBuenosProg;
  String trabajo;
  String estado;
  int codigoMotivo;
  String descripcionMotivo;
  String inicioEstadoActual;
  String inicioProceso;
  double horasDesdeInicio;
  double horaFinalizacion;
  double horasBarra;
  double cantidadBuenos;
  double cantidadMalos;
  double porcAvance;
  String descOperario;
  String descTurno;
  double cantidadHorasProgPrep;
  double cantidadHorasProgProd;
  double cantidadHoraProgPar;
  double cantidadHorasProgTotales;
  double tiempoPreUtilizado;
  double tiempoProUtilizado;
  double tiempoParUtilizado;
  double velocidadActual;
  int cs;
  int cr;
  double inicio;
  int red;
  int green;
  int blue;

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
      this.horasBarra,
      this.cantidadBuenos,
      this.cantidadMalos,
      this.porcAvance,
      this.descOperario,
      this.descTurno,
      this.cantidadHorasProgPrep,
      this.cantidadHorasProgProd,
      this.cantidadHoraProgPar,
      this.cantidadHorasProgTotales,
      this.tiempoPreUtilizado,
      this.tiempoProUtilizado,
      this.tiempoParUtilizado,
      this.velocidadActual,
      this.cs,
      this.cr,
      this.inicio,
      this.red,
      this.green,
      this.blue});

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
    cantBuenosProg = double.parse(json['cant_buenos_prog'].toString());
    trabajo = json['trabajo'];
    estado = json['estado'];
    codigoMotivo = json['codigo_motivo'];
    descripcionMotivo = json['descripcion_motivo'];
    inicioEstadoActual = json['inicio_estado_actual'];
    inicioProceso = json['inicio_proceso'];
    horasDesdeInicio = double.parse(json['horas_desde_inicio'].toString());
    horaFinalizacion = double.parse(json['hora_finalizacion'].toString());
    horasBarra = double.parse(json['horas_barra'].toString());
    cantidadBuenos = double.parse(json['cantidad_buenos'].toString());
    cantidadMalos = double.parse(json['cantidad_malos'].toString());
    porcAvance = double.parse(json['porc_avance'].toString());
    descOperario = json['desc_operario'];
    descTurno = json['desc_turno'];
    cantidadHorasProgPrep = double.parse(json['cantidadHoras_prog_prep'].toString());
    cantidadHorasProgProd = double.parse(json['cantidadHoras_prog_prod'].toString());
    cantidadHoraProgPar = double.parse(json['cantidadHora_prog_par'].toString());
    cantidadHorasProgTotales = double.parse(json['cantidadHoras_prog_totales'].toString());
    tiempoPreUtilizado = double.parse(json['tiempo_pre_utilizado'].toString());
    tiempoProUtilizado = double.parse(json['tiempo_pro_utilizado'].toString());
    tiempoParUtilizado = double.parse(json['tiempo_par_utilizado'].toString());
    velocidadActual = double.parse(json['velocidad_actual'].toString());
    cs = json['cs'];
    cr = json['cr'];
    inicio = json['inicio'];
    red = json['red'];
    green = json['green'];
    blue = json['blue'];
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
    data['horas_barra'] = this.horasBarra;
    data['cantidad_buenos'] = this.cantidadBuenos;
    data['cantidad_malos'] = this.cantidadMalos;
    data['porc_avance'] = this.porcAvance;
    data['desc_operario'] = this.descOperario;
    data['desc_turno'] = this.descTurno;
    data['cantidadHoras_prog_prep'] = this.cantidadHorasProgPrep;
    data['cantidadHoras_prog_prod'] = this.cantidadHorasProgProd;
    data['cantidadHora_prog_par'] = this.cantidadHoraProgPar;
    data['cantidadHoras_prog_totales'] = this.cantidadHorasProgTotales;
    data['tiempo_pre_utilizado'] = this.tiempoPreUtilizado;
    data['tiempo_pro_utilizado'] = this.tiempoProUtilizado;
    data['tiempo_par_utilizado'] = this.tiempoParUtilizado;
    data['velocidad_actual'] = this.velocidadActual;
    data['cs'] = this.cs;
    data['cr'] = this.cr;
    data['inicio'] = this.inicio;
    data['red'] = this.red;
    data['green'] = this.green;
    data['blue'] = this.blue;
    return data;
  }
}