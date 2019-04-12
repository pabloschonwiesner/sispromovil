import 'package:flutter/material.dart';
import 'package:sispromovil/bd/Database.dart';
import 'package:sispromovil/bd/ParamsModel.dart';
import 'package:sispromovil/pages/Home.dart';

class Configuracion extends StatefulWidget {
  static const String routeName = '/configuracion';
  @override
  _Configuracion createState() => _Configuracion();
}

class _Configuracion extends State<Configuracion> with TickerProviderStateMixin {
  TextEditingController _plantaController = TextEditingController();
  TextEditingController _codigoController = TextEditingController();
  TextEditingController _servidorController = TextEditingController();
  TextEditingController _puertoController = TextEditingController();
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
      "puerto": int.parse(_puertoController.text),
      "seleccionada": 0
    };
    ParamsModel params = ParamsModel.fromMap(paramsMap);
    DBProvider.db.addParams(params);
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
              TextFormField(  
                controller: _puertoController,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Puerto Servidor Web',
                  labelText: 'Puerto Servidor Web'
                ),
                keyboardType: TextInputType.number,
                
                onSaved: (String value) {
                  setState(() {
                    _puertoController.text = value;
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