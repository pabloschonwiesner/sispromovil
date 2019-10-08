import 'package:flutter/material.dart';
export 'package:provider/provider.dart';
import 'package:sispromovil/models/BusquedaModel.dart';

class BusquedaProvider with ChangeNotifier {
  BusquedaModel _busqueda = BusquedaModel();

  BusquedaModel get getBusqueda => _busqueda;

  void setBusqueda (BusquedaModel b) {
    this._busqueda = b;
    notifyListeners();
  }
}