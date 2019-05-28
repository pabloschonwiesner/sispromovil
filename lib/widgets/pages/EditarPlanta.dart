import 'package:flutter/material.dart';
import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sispromovil/models/RegistroModel.dart';
import 'package:sispromovil/repositories/registro/Registro_Repository.dart';
import 'package:sispromovil/widgets/pages/Home.dart';
import 'package:sispromovil/blocs/plantas/BlocPlanta.dart';
import 'package:sispromovil/blocs/plantas/BlocPlantaProvider.dart';

class EditarPlanta extends StatefulWidget {
  final PlantaModel planta;
  EditarPlanta(this.planta);

  @override
  _EditarPlanta createState() => _EditarPlanta();
}

class _EditarPlanta extends State<EditarPlanta> with TickerProviderStateMixin {
  TextEditingController _plantaController = TextEditingController();
  TextEditingController _codigoController = TextEditingController();
  TextEditingController _servidorController = TextEditingController();
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      _plantaController.text = widget.planta.planta;
      _codigoController.text = widget.planta.codigo;
      _servidorController.text = widget.planta.servidor;
    });
  }

  void _guardarPlanta() async {
    _keyForm.currentState.save();
    RegistroRepository _repositoryRegistro = RegistroRepository();
    RegistroModel _registro = await _repositoryRegistro.fetchRegistro(_codigoController.text);
    _servidorController.text = _registro.data[0].servidor;
    
    if(_registro.data.isNotEmpty) {
      final Map<String, dynamic> paramsMap = {
        "id": widget.planta.id,
        "planta": _plantaController.text,
        "codigo": _codigoController.text,
        "servidor": _servidorController.text,
        "seleccionada": widget.planta.seleccionada
      };
      PlantaModel planta = PlantaModel.fromMap(paramsMap);
      blocPlanta.actualizarPlanta(planta);
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
        title: Text(widget.planta.planta),
        actions: <Widget>[
          widget.planta.id != 1 
          ? IconButton(            
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Eliminar planta'),
                    content: Text('¿Está seguro que quiere eliminar la planta?'),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.check), 
                        color: Colors.green, 
                        onPressed: () {
                          blocPlanta.deletePlanta(widget.planta);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Home()
                          ));
                        }),
                      IconButton(icon: Icon(Icons.clear), color: Colors.red, onPressed: () => Navigator.pop(context),)
                    ],
                  );
                }
              );
            },
          )
          : Center(child: Text(''),)
        ],
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
                    labelText: 'Planta'
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
                    labelText: 'Codigo'
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
                widget.planta.id != 1 ?
                  TextFormField(                 
                    enabled: false,       
                    style: TextStyle(color: Colors.grey),               
                    controller: _servidorController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Ruta Servidor Web',
                      labelText: 'Servidor Web',                                            
                    ),
                    keyboardType: TextInputType.text,                    
                    onSaved: (String value) {
                      setState(() {
                        _servidorController.text = value;
                      });
                    },
                  ) : Container(),
                
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
                )
              ],
            ),
          )
        ),
      )
    );
  }
}