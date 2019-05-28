class RegistroModel {
  List<Data> data;

  RegistroModel({this.data});

  RegistroModel.fromJson(Map<String, dynamic> json) {
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
  String servidor;

  Data({this.servidor});

  Data.fromJson(Map<String, dynamic> json) {
    servidor = json['servidor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['servidor'] = this.servidor;
    return data;
  }
}