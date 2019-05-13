import 'package:sispromovil/repositories/otPendientes/OT_Pendientes_Repository_http.dart';
import 'package:sispromovil/models/PendientesModel.dart';

class OTPendientesRepository {

  OTPendientesApiProvider provider = OTPendientesApiProvider();

  Future<PendientesModel> fetchAllOTPendientes(String url) => provider.fetchOTPendientes(url);
}