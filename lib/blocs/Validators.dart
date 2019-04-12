import 'dart:async';
import 'package:sispromovil/bd/ParamsModel.dart';

class Validators {
  final validateSearch = StreamTransformer<String, String>.fromHandlers(
    handleData: (search, sink) {
      if(!search.contains('@')) {
        sink.add(search);
      } else {
        sink.addError('Texto no valido para la busqueda');
      }
    }
  );

  final validatePlanta = StreamTransformer<ParamsModel, dynamic>.fromHandlers(
    handleData: (planta, sink) {
      if(planta.planta.isNotEmpty) {
        sink.add(planta);
      } else {
        sink.addError('Falta el nombre de la planta');
      }
    }
  );
}