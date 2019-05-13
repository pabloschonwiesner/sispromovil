import 'package:flutter/material.dart';
import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sispromovil/widgets/pages/Home.dart';
import 'package:sispromovil/blocs/plantas/BlocPlanta.dart';
import 'package:sispromovil/blocs/plantas/BlocPlantaProvider.dart';

class CrearPlanta extends StatefulWidget {
  static const String routeName = '/crearPlanta';
  @override
  _CrearPlanta createState() => _CrearPlanta();
}

class _CrearPlanta extends State<CrearPlanta> with TickerProviderStateMixin {
  TextEditingController _plantaController = TextEditingController();
  TextEditingController _codigoController = TextEditingController();
  TextEditingController _servidorController = TextEditingController();
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
  }

  void _guardarPlanta() {
    final Map<String, dynamic> paramsMap = {
      "id": 0,
      "planta": _plantaController.text,
      "codigo": _codigoController.text,
      "servidor": _servidorController.text,
      "seleccionada": 0
    };
    PlantaModel planta = PlantaModel.fromMap(paramsMap);
    blocPlanta.agregarPlanta(planta);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Home()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva planta') ,
      ),
      body: Form(
        key: _keyForm,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(  
                controller: _plantaController,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Nombre de la planta',
                  labelText: 'Planta'
                ),
                keyboardType: TextInputType.text,
                
                onSaved: (String value) {
                  setState(() {
                    _plantaController.text = value;
                  });
                },
              ),
              TextFormField(  
                controller: _codigoController,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Codigo de cliente o promocion',
                  labelText: 'Codigo'
                ),
                keyboardType: TextInputType.text,
                
                onSaved: (String value) {
                  setState(() {
                    _codigoController.text = value;
                  });
                },
              ),
              TextFormField(  
                controller: _servidorController,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Ruta Servidor Web',
                  labelText: 'Servidor Web'
                ),
                keyboardType: TextInputType.text,
                
                onSaved: (String value) {
                  setState(() {
                    _servidorController.text = value;
                  });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                child: Text('Guardar'),
                elevation: 10,
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: () => _guardarPlanta(),
              )
            ],
          ),
        )
      )
    );
  }
} // final class _Configuracion