import 'package:rxdart/rxdart.dart';
import 'package:sispromovil/models/PendientesModel.dart';
import 'package:sispromovil/repositories/otPendientes/OT_Pendientes_Repository.dart';
import 'package:sispromovil/blocs/plantas/BlocPlanta.dart';


class BlocOTPendientes {
  PendientesModel _listaOTs;
  String urlData = '';
  OTPendientesRepository _repository = OTPendientesRepository();
  BehaviorSubject<PendientesModel> _listaOTPendientes = BehaviorSubject<PendientesModel>();
  BehaviorSubject<String> _filtro = BehaviorSubject<String>();
  BehaviorSubject<String> _servidor = BehaviorSubject<String>();
  BehaviorSubject<String> _url = BehaviorSubject<String>();
  BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>.seeded(false);
  // BehaviorSubject<int> _parcialItems = BehaviorSubject<int>();
  BehaviorSubject<int> _desdeItem = BehaviorSubject<int>.seeded(1);

  BlocOTPendientes() {
    initialData();
  }

  void initialData() {
    filtro.add('');
    // url.listen((ruta) => print(ruta));
    // _servidor.listen((onData) => print('Prueba: $onData'));
    // llenarListaOTPendientes();
  }

  BehaviorSubject<PendientesModel> get listaOTPendientes => _listaOTPendientes.stream;
  BehaviorSubject<String> get servidor => _servidor.stream;
  BehaviorSubject<String> get filtro => _filtro.stream;
  BehaviorSubject<String> get url => _url.stream;
  BehaviorSubject<bool> get isLoading => _isLoading.stream;
  // BehaviorSubject<int> get parcialItems => _parcialItems.stream;
  BehaviorSubject<int> get desdeItem => _desdeItem.stream;

  Function(String) get changeServidor => _servidor.sink.add;
  Function(String) get changeFiltro => _filtro.sink.add;
  Function(bool) get changeIsLoading => _isLoading.sink.add;
  // Function(int) get changeParcialItems => _parcialItems.sink.add;
  Function(int) get changeDesdeItem => _desdeItem.sink.add;
  


  Stream<String> get changeUrl => Observable.combineLatest3(
    servidor, filtro, desdeItem, (serv, fil, desde) {
      print('Serv: $serv // Fil: $fil // Desde: $desde ');
      String url;
      if(fil.toString().isNotEmpty) {
        url = '$serv/pendientes?desde=$desde&cantRegistros=30&filtro=$fil';
        _listaOTs = null;
      } else {
        url = '$serv/pendientes?desde=$desde&cantRegistros=30';
      }
      print('Url desde el bloc: $url');
      urlData = url;
      _url.sink.add(url);      
    });

  void llenarListaOTPendientes()  async {  
    url.listen((data) {
      urlData = data;
      print('Desde listener $urlData');
    });
    print('UrlData: $urlData');
    PendientesModel temp = await _repository.fetchAllOTPendientes(urlData);
    if(_listaOTs == null) {
      _listaOTs = temp;
    } else {
      _listaOTs.data.addAll(temp.data);
    }
  //   changeParcialItems(_listaOTs.data.length);
    _listaOTPendientes.sink.add(_listaOTs);
  }

  void dispose() async {
    await _listaOTPendientes.drain();
    _listaOTPendientes.close();
    await _filtro.drain();
    _filtro.close();
    await _servidor.drain();
    _servidor.close();
    await _url.drain();
    _url.close();
    await _isLoading.drain();
    _isLoading.close();
    // await _parcialItems.drain();
    // _parcialItems.close();
    await _desdeItem.drain();
    _desdeItem.close();
  }

}

var blocOTPendientes = BlocOTPendientes();