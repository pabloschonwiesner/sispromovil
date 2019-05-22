import 'package:flutter/material.dart';
import 'package:sispromovil/blocs/ordenesEnCurso/BlocOTEnCurso.dart';
export 'package:sispromovil/blocs/ordenesEnCurso/BlocOTEnCurso.dart';

class BlocOTEnCursoProvider extends InheritedWidget {
  final BlocOTEnCurso otEnCursoBloc;

  BlocOTEnCursoProvider({
    Key key, 
    BlocOTEnCurso otEnCursoBloc,
    Widget child
  })  : this.otEnCursoBloc = otEnCursoBloc ?? BlocOTEnCurso(), 
        super(key: key, child: child);
  
  bool updateShouldNotify(_) => true;

  static BlocOTEnCurso of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocOTEnCursoProvider) as BlocOTEnCursoProvider).otEnCursoBloc;
  }

}
