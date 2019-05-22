import 'package:flutter/material.dart';
import 'package:sispromovil/blocs/ordenesPendientes/BlocOTPendientes.dart';
export 'package:sispromovil/blocs/ordenesPendientes/BlocOTPendientes.dart';

class BlocOTPendientesProvider extends InheritedWidget {
  final BlocOTPendientes otPendientesBloc;

  BlocOTPendientesProvider({
    Key key, 
    BlocOTPendientes otPendientesBloc,
    Widget child
  })  : this.otPendientesBloc = otPendientesBloc ?? BlocOTPendientes(), 
        super(key: key, child: child);
  
  bool updateShouldNotify(_) => true;

  static BlocOTPendientes of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocOTPendientesProvider) as BlocOTPendientesProvider).otPendientesBloc;
  }

}
