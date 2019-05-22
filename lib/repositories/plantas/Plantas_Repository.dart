import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository_sqlite.dart';


class PlantasRepository {
  final PlantaProvider plantaProvider = PlantaProvider.db;

  PlantasRepository();

  Future<List<PlantaModel>> getPlantas() {
    return plantaProvider.getListPlantas();
  }

  Stream<PlantaModel> getPlanta(int id) {
    return plantaProvider.getPlanta(id);
  }

  Future getPlantaSelect() {
    return plantaProvider.getPlantaSelect();
  }

  void selectPlanta(int id) {
    plantaProvider.selectPlanta(id);
  }

  void addPlanta(PlantaModel planta) {
    return plantaProvider.addPlanta(planta);
  }

  void updatePlanta(PlantaModel planta) {
    return plantaProvider.updatePlanta(planta);
  }

  void deletePlanta(PlantaModel planta) {
    return plantaProvider.deletePlanta(planta);
  }
}