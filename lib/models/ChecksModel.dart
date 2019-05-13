class ChecksModel {
  List<Data> data;

  ChecksModel({this.data});

  ChecksModel.fromJson(Map<String, dynamic> json) {
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
  List<Geop> geop;
  List<CheckList> checkList;

  Data({this.geop, this.checkList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['geop'] != null) {
      geop = new List<Geop>();
      json['geop'].forEach((v) {
        geop.add(new Geop.fromJson(v));
      });
    }
    if (json['checkList'] != null) {
      checkList = new List<CheckList>();
      json['checkList'].forEach((v) {
        checkList.add(new CheckList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.geop != null) {
      data['geop'] = this.geop.map((v) => v.toJson()).toList();
    }
    if (this.checkList != null) {
      data['checkList'] = this.checkList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Geop {
  String origen;
  String clave;
  String valor;

  Geop({this.origen, this.clave, this.valor});

  Geop.fromJson(Map<String, dynamic> json) {
    origen = json['Origen'];
    clave = json['Clave'];
    valor = json['Valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Origen'] = this.origen;
    data['Clave'] = this.clave;
    data['Valor'] = this.valor;
    return data;
  }
}

class CheckList {
  String origen;
  String clave;
  String valor;

  CheckList({this.origen, this.clave, this.valor});

  CheckList.fromJson(Map<String, dynamic> json) {
    origen = json['Origen'];
    clave = json['Clave'];
    valor = json['Valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Origen'] = this.origen;
    data['Clave'] = this.clave;
    data['Valor'] = this.valor;
    return data;
  }
}