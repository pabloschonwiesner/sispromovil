import 'package:flutter/material.dart';
import 'package:sispromovil/blocs/ordenesPendientes/BlocOTPendientes.dart';
export 'package:sispromovil/blocs/ordenesPendientes/BlocOTPendientes.dart';

class BlocOTPendientesProvider extends InheritedWidget {
  final bloc = BlocOTPendientes();

  BlocOTPendientesProvider({Key key, Widget child}) : super(key: key, child: child);
  
  bool updateShouldNotify(_) => true;

  static BlocOTPendientes of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocOTPendientesProvider) as BlocOTPendientesProvider).bloc;
  }

}
