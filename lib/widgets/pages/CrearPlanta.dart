import 'package:flutter/material.dart';
import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sispromovil/models/RegistroModel.dart';
import 'package:sispromovil/widgets/pages/Home.dart';
import 'package:sispromovil/blocs/plantas/BlocPlanta.dart';
import 'package:sispromovil/blocs/plantas/BlocPlantaProvider.dart';
import 'package:sispromovil/repositories/registro/Registro_Repository.dart';

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
  GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    super.initState();
  }

  void _guardarPlanta() async {   
    RegistroRepository _repositoryRegistro = RegistroRepository();
    RegistroModel _registro = await _repositoryRegistro.fetchRegistro(_codigoController.text);
    if(_registro.data.isNotEmpty) {
      final Map<String, dynamic> paramsMap = {
        "id": 0,
        "planta": _plantaController.text,
        "codigo": _codigoController.text,
        "servidor": _registro.data[0].servidor,
        "seleccionada": 0
      };
      PlantaModel planta = PlantaModel.fromMap(paramsMap);
      blocPlanta.agregarPlanta(planta);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Home()
      ));
    } else {
      _keyScaffold.currentState.showSnackBar(SnackBar(content: Text('El codigo de planta no es válido')));
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyScaffold,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Nueva planta') ,
      ),
      body: SingleChildScrollView(
          child: Form(
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
                      labelText: 'Planta',
                    ),
                    keyboardType: TextInputType.text,                  
                    onSaved: (String value) {
                      setState(() {
                        _plantaController.text = value;
                      });
                    },
                    validator: (String value) {
                      if(value.isEmpty) {
                        return 'Ingrese la planta';
                      }
                    }
                  ),
                  TextFormField(  
                    controller: _codigoController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Codigo de cliente o promocion',
                      labelText: 'Codigo',
                    ),
                    keyboardType: TextInputType.text,                  
                    onSaved: (String value) {
                      setState(() {
                        _codigoController.text = value;
                      });
                    },
                    validator: (String value) {
                      if(value.isEmpty) {
                        return 'Ingrese el codigo';
                      }
                    }
                  ),
                  SizedBox(height: 20,),
                  RaisedButton(                  
                    child: Text('Guardar'),
                    elevation: 10,
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if(_keyForm.currentState.validate()) {
                        return _guardarPlanta();
                      } else {
                        return null;
                      }
                    }
                    //_plantaValida && _codigoValido ? _guardarPlanta() : null,
                  )
                ],
              ),
            )
        ),
      )
    );
  }
} // final class _Configuracion