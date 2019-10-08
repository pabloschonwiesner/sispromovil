import 'package:flutter/material.dart';
// import 'package:sispromovil/models/BusquedaModel.dart';
import 'package:sispromovil/providers/BusquedaProvider.dart';
import 'package:sispromovil/widgets/pages/CrearPlanta.dart';
import 'package:sispromovil/widgets/pages/OrdenesPendientes.dart';
import 'package:sispromovil/widgets/pages/OrdenesPendientesPlanificadas.dart';
import 'package:sispromovil/widgets/pages/OrdenesEnCurso.dart';
import 'package:sispromovil/widgets/pages/OrdenesFinalizadas.dart';
import 'package:sispromovil/blocs/plantas/BlocPlantaProvider.dart';
import 'package:sispromovil/widgets/pages/Splash.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider( builder: (context) => BusquedaProvider()),
  ],
  child:   MaterialApp(  
    debugShowCheckedModeBanner: false,  
    theme: ThemeData(  
      primaryColor: Colors.lightBlue[900],  
      accentColor: Colors.lightBlue[900],  
      backgroundColor: Colors.grey[300]  
    ),  
    home: BlocPlantaProvider(  
      child: Splash(),  
    ),  
    routes: <String, WidgetBuilder> {  
      OrdenesPendientes.routeName: (BuildContext context) => OrdenesPendientes(),  
      // OrdenesPendientesPlanificadas.routeName: (BuildContext context) => OrdenesPendientesPlanificadas(),  
      // OrdenesEnCurso.routeName: (BuildContext context) => OrdenesEnCurso(),  
      // OrdenesFinalizadas.routeName: (BuildContext context) => OrdenesFinalizadas(),  
      // CrearPlanta.routeName: (BuildContext context) => CrearPlanta()  
    },  
  ),
)
  
);
