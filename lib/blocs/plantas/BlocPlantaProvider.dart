import 'package:flutter/material.dart';
import 'package:sispromovil/blocs/plantas/BlocPlanta.dart';
export 'package:sispromovil/blocs/plantas/BlocPlanta.dart';

class BlocPlantaProvider extends InheritedWidget {
  final bloc = BlocPlanta();

  BlocPlantaProvider({Key key, Widget child}) : super(key: key, child: child);
  
  bool updateShouldNotify(_) => true;

  static BlocPlanta of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocPlantaProvider) as BlocPlantaProvider).bloc;
  }

}
