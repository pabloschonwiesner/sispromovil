class NotificacionesModel {
  int totalRegistros;
  List<Data> data;

  NotificacionesModel({this.totalRegistros, this.data});

  NotificacionesModel.fromJson(Map<String, dynamic> json) {
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
  String codigoInterno;
  int codigo;
  int codigoSolapa;
  int codigoRenglon;
  int codigoTablero;
  String mensaje;
  bool notificado;
  String fechaHora;
  int codigoUsuario;
  String maquina;
  String id;
  String subId;

  Data(
      {this.codigoInterno,
      this.codigo,
      this.codigoSolapa,
      this.codigoRenglon,
      this.codigoTablero,
      this.mensaje,
      this.notificado,
      this.fechaHora,
      this.codigoUsuario,
      this.maquina,
      this.id,
      this.subId});

  Data.fromJson(Map<String, dynamic> json) {
    codigoInterno = json['codigo_interno'];
    codigo = json['Codigo'];
    codigoSolapa = json['CodigoSolapa'];
    codigoRenglon = json['CodigoRenglon'];
    codigoTablero = json['CodigoTablero'];
    mensaje = json['Mensaje'];
    notificado = json['Notificado'];
    fechaHora = json['FechaHora'];
    codigoUsuario = json['CodigoUsuario'];
    maquina = json['Maquina'];
    id = json['ID'];
    subId = json['SubID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo_interno'] = this.codigoInterno;
    data['Codigo'] = this.codigo;
    data['CodigoSolapa'] = this.codigoSolapa;
    data['CodigoRenglon'] = this.codigoRenglon;
    data['CodigoTablero'] = this.codigoTablero;
    data['Mensaje'] = this.mensaje;
    data['Notificado'] = this.notificado;
    data['FechaHora'] = this.fechaHora;
    data['CodigoUsuario'] = this.codigoUsuario;
    data['Maquina'] = this.maquina;
    data['ID'] = this.id;
    data['SubID'] = this.subId;
    return data;
  }
}