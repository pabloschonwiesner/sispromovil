import 'package:flutter/material.dart';
import 'package:sispromovil/widgets/pages/Home.dart';
import 'package:sispromovil/widgets/pages/CrearPlanta.dart';
import 'package:sispromovil/widgets/pages/OrdenesPendientes.dart';
import 'package:sispromovil/widgets/pages/OrdenesPendientesPlanificadas.dart';
import 'package:sispromovil/widgets/pages/OrdenesEnCurso.dart';
import 'package:sispromovil/widgets/pages/OrdenesFinalizadas.dart';
import 'package:sispromovil/blocs/plantas/BlocPlantaProvider.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue[900],
        accentColor: Colors.lightBlue[900],
        backgroundColor: Colors.grey[300]
      ),
      home: BlocPlantaProvider(
        child: Home(),
      ),
      routes: <String, WidgetBuilder> {
        OrdenesPendientes.routeName: (BuildContext context) => OrdenesPendientes(),
        OrdenesPendientesPlanificadas.routeName: (BuildContext context) => OrdenesPendientesPlanificadas(),
        OrdenesEnCurso.routeName: (BuildContext context) => OrdenesEnCurso(),
        OrdenesFinalizadas.routeName: (BuildContext context) => OrdenesFinalizadas(),
        CrearPlanta.routeName: (BuildContext context) => CrearPlanta()
      },
    )
  
);
