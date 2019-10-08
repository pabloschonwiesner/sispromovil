import 'package:sispromovil/models/BusquedaModel.dart';
import 'package:sispromovil/repositories/busquedas/Busquedas_Repository_sqlite.dart';

class BusquedaRepository {
  final BusquedaProviderBD busquedaProviderBD = BusquedaProviderBD.db;

  BusquedaRepository();

  Future<List<BusquedaModel>> getBusquedas() {
    return busquedaProviderBD.getBusquedas();
  }

  Future<BusquedaModel> getBusqueda(int id) {
    return busquedaProviderBD.getBusqueda(id);
  }

  Future<int> addBusqueda(String query) {
    return busquedaProviderBD.addBusqueda(query);
  }

  void deleteBusqueda(int id) {
    busquedaProviderBD.deleteBusqueda(id);
  }
}