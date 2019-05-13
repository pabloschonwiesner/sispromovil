import 'package:flutter/material.dart';
import 'package:sispromovil/blocs/busqueda/BlocBusqueda.dart';
export 'package:sispromovil/blocs/busqueda/BlocBusqueda.dart';

class BlocBusquedaProvider extends InheritedWidget {
  final bloc = BlocBusqueda();

  BlocBusquedaProvider({Key key, Widget child}) : super(key: key, child: child);
  
  bool updateShouldNotify(_) => true;

  static BlocBusqueda of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocBusquedaProvider) as BlocBusquedaProvider).bloc;
  }

}
