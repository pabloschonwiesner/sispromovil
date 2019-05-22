import 'package:sispromovil/repositories/otPendientesPlanificadas/OT_Pendientes_Planificadas_Repository_http.dart';
import 'package:sispromovil/models/PendientesPlanificadasModel.dart';

class OTPendientesPlanificadasRepository {

  OTPendientesPlanificadasApiProvider provider = OTPendientesPlanificadasApiProvider();

  Future<PendientesPlanificadasModel> fetchAllOTPendientesPlanificadas(String url) => provider.fetchOTPendientesPlanificadas(url);
}