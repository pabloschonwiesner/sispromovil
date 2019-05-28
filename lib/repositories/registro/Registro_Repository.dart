import 'package:sispromovil/repositories/registro/Registro_Repository_http.dart';
import 'package:sispromovil/models/RegistroModel.dart';

class RegistroRepository {

  RegistroApiProvider provider = RegistroApiProvider();

  Future<RegistroModel> fetchRegistro(String codigo) => provider.fetchRegistro(codigo);
}