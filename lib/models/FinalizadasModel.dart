class FinalizadasModel {
  List<Data> data;

  FinalizadasModel({this.data});

  FinalizadasModel.fromJson(Map<String, dynamic> json) {
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
  String trabajo;
  String fechaInicioOt;
  String fechaFinOt;
  String horaFinalizacion;
  int cantBuenasProg;
  int cantMalasProg;
  int cantidadBuenos;
  int cantidadMalos;
  int difCantNuenos;
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
      this.trabajo,
      this.fechaInicioOt,
      this.fechaFinOt,
      this.horaFinalizacion,
      this.cantBuenasProg,
      this.cantMalasProg,
      this.cantidadBuenos,
      this.cantidadMalos,
      this.difCantNuenos,
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
    trabajo = json['trabajo'];
    fechaInicioOt = json['fecha_inicio_ot'];
    fechaFinOt = json['fecha_fin_ot'];
    horaFinalizacion = json['hora_finalizacion'];
    cantBuenasProg = json['cant_buenas_prog'];
    cantMalasProg = json['cant_malas_prog'];
    cantidadBuenos = json['cantidad_buenos'];
    cantidadMalos = json['cantidad_malos'];
    difCantNuenos = json['dif_cant_nuenos'];
    difCantMalos = json['dif_cant_malos'];
    porcCompletado = json['porc_completado'];
    cantidadHorasProgPrep = json['cantidad_horas_prog_prep'];
    cantidadHorasProgProd = json['cantidad_horas_prog_prod'];
    cantidadHorasProgPar = json['cantidad_horas_prog_par'];
    tiempoPreUtilizado = json['tiempo_pre_utilizado'];
    tiempoProUtilizado = json['tiempo_pro_utilizado'];
    tiempoParUtilizado = json['tiempo_par_utilizado'];
    usuario = json['usuario'];
    codigoSolapa = json['codigo_solapa'];
    codigoRenglon = json['codigo_renglon'];
    horaInicio = json['hora_inicio'];
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
    data['trabajo'] = this.trabajo;
    data['fecha_inicio_ot'] = this.fechaInicioOt;
    data['fecha_fin_ot'] = this.fechaFinOt;
    data['hora_finalizacion'] = this.horaFinalizacion;
    data['cant_buenas_prog'] = this.cantBuenasProg;
    data['cant_malas_prog'] = this.cantMalasProg;
    data['cantidad_buenos'] = this.cantidadBuenos;
    data['cantidad_malos'] = this.cantidadMalos;
    data['dif_cant_nuenos'] = this.difCantNuenos;
    data['dif_cant_malos'] = this.difCantMalos;
    data['porc_completado'] = this.porcCompletado;
    data['cantidad_horas_prog_prep'] = this.cantidadHorasProgPrep;
    data['cantidad_horas_prog_prod'] = this.cantidadHorasProgProd;
    data['cantidad_horas_prog_par'] = this.cantidadHorasProgPar;
    data['tiempo_pre_utilizado'] = this.tiempoPreUtilizado;
    data['tiempo_pro_utilizado'] = this.tiempoProUtilizado;
    data['tiempo_par_utilizado'] = this.tiempoParUtilizado;
    data['usuario'] = this.usuario;
    data['codigo_solapa'] = this.codigoSolapa;
    data['codigo_renglon'] = this.codigoRenglon;
    data['hora_inicio'] = this.horaInicio;
    return data;
  }
}