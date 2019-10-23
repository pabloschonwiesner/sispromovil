import 'package:shared_preferences/shared_preferences.dart';
import 'package:sispromovil/models/PlantaModel.dart';

void setPlanta(PlantaModel planta) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('id', planta.id);
  await prefs.setString('planta', planta.planta);
  await prefs.setString('codigo', planta.codigo);
  await prefs.setString('servidor', planta.servidor);
  await prefs.setInt('seleccionada', planta.seleccionada);
}

Future<PlantaModel> getPlanta() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return PlantaModel(
    id: prefs.getInt('id'),
    planta: prefs.getString('planta'),
    codigo: prefs.getString('codigo'),
    servidor: prefs.getString('servidor'),
    seleccionada: prefs.getInt('seleccionada')
  );
}
