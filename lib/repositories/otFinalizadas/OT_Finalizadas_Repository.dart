import 'package:sispromovil/repositories/otFinalizadas/OT_Finalizadas_Repository_http.dart';
import 'package:sispromovil/models/FinalizadasModel.dart';

class OTFinalizadasRepository {

  OTFinalizadasApiProvider provider = OTFinalizadasApiProvider();

  Future<FinalizadasModel> fetchAllOTFinalizadas(String url) => provider.fetchOTFinalizadas(url);
}