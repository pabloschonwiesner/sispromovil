import 'package:flutter/material.dart';
import 'package:sispromovil/pages/Home.dart';
import 'package:sispromovil/pages/Configuracion.dart';
import 'package:sispromovil/pages/OrdenesPendientes.dart';
import 'package:sispromovil/pages/OrdenesPendientesPlanificadas.dart';
import 'package:sispromovil/pages/OrdenesEnCurso.dart';
import 'package:sispromovil/pages/OrdenesFinalizadas.dart';
import 'package:sispromovil/blocs/Bloc.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: Colors.lightBlue[900],
    accentColor: Colors.lightBlue[900],
    backgroundColor: Colors.grey[300]
  ),
  home: Home(),
  routes: <String, WidgetBuilder> {
    OrdenesPendientes.routeName: (BuildContext context) => OrdenesPendientes(),
    OrdenesPendientesPlanificadas.routeName: (BuildContext context) => OrdenesPendientesPlanificadas(),
    OrdenesEnCurso.routeName: (BuildContext context) => OrdenesEnCurso(),
    OrdenesFinalizadas.routeName: (BuildContext context) => OrdenesFinalizadas(),
    Configuracion.routeName: (BuildContext context) => Configuracion()
  },
));
