import 'package:sispromovil/repositories/otEnCurso/OT_EnCurso_Repository_http.dart';
import 'package:sispromovil/models/EnCursoModel.dart';

class OTEnCursoRepository {

  OTEnCursoApiProvider provider = OTEnCursoApiProvider();

  Future<EnCursoModel> fetchAllOTEnCurso(String url) => provider.fetchOTEnCurso(url);
}