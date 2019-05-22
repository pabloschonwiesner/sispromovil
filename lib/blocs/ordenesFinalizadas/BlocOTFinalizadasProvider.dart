import 'package:flutter/material.dart';
import 'package:sispromovil/blocs/ordenesFinalizadas/BlocOTFinalizadas.dart';
export 'package:sispromovil/blocs/ordenesFinalizadas/BlocOTFinalizadas.dart';

class BlocOTFinalizadasProvider extends InheritedWidget {
  final BlocOTFinalizadas otFinalizadasBloc;

  BlocOTFinalizadasProvider({
    Key key, 
    BlocOTFinalizadas otFinalizadasBloc,
    Widget child
  })  : this.otFinalizadasBloc = otFinalizadasBloc ?? BlocOTFinalizadas(), 
        super(key: key, child: child);
  
  bool updateShouldNotify(_) => true;

  static BlocOTFinalizadas of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocOTFinalizadasProvider) as BlocOTFinalizadasProvider).otFinalizadasBloc;
  }

}
