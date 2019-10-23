import 'package:flutter/material.dart';
export 'package:provider/provider.dart';
import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository.dart';

class PlantaProvider extends ChangeNotifier {
  PlantaModel _planta = PlantaModel();
  PlantasRepository _repoPlanta = PlantasRepository();
  PlantaModel plantaSeleccionada;


  PlantaProvider() {
    getPlantaSeleccionada();
  }

  void getPlantaSeleccionada() async {
    plantaSeleccionada = await _repoPlanta.getPlantaSelect();
    setPlanta(plantaSeleccionada);
  }

  PlantaModel get getPlanta => _planta;

  void setPlanta(PlantaModel planta) {
    _planta = planta;
    notifyListeners();
  }

}
