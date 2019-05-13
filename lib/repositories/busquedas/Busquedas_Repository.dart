import 'package:sispromovil/models/BusquedaModel.dart';
import 'package:sispromovil/repositories/busquedas/Busquedas_Repository_sqlite.dart';

class BusquedaRepository {
  final BusquedaProvider busquedaProvider = BusquedaProvider.db;

  BusquedaRepository();

  Future<List<BusquedaModel>> getBusquedas() {
    return busquedaProvider.getBusquedas();
  }

  void addBusqueda(String query) {
    busquedaProvider.addBusqueda(query);
  }

  void deleteBusqueda(int id) {
    busquedaProvider.deleteBusqueda(id);
  }
}