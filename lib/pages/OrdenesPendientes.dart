import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sispromovil/models/PendientesModel.dart';

const baseUrl = 'http://10.0.3.2:3002/pendientes';

class OrdenesPendientes extends StatefulWidget {
  static const String routeName = '/pendientes';
  @override
  _OrdenesPendientes createState() => _OrdenesPendientes();
  }
  

class _OrdenesPendientes extends State<OrdenesPendientes> {
  PendientesModel itemsPendientes;

  @override
  void initState() {
    super.initState();
    _obtenerPendientes();
  }

  void _obtenerPendientes() async {
    var response = await http.get(baseUrl);
    if(response.statusCode == 200) {
      setState(() {
        var decodeJson = jsonDecode(response.body);
        itemsPendientes = PendientesModel.fromJson(decodeJson);
        print(itemsPendientes.toJson());
      });
    } else {
      print('error');
    }    
  }

  Widget _listaOps() => Column(
    children: 
      itemsPendientes == null
      ? <Widget>[Center(child: CircularProgressIndicator())]
      : itemsPendientes.data
        .map<Widget>((item) => _op(item))
        .toList()
    
  );

  Widget _op(Data op) {
    return Row(children: <Widget>[
      Expanded(child: Text(op.trabajo, overflow: TextOverflow.ellipsis),)
    ],);
  }

 @override
 Widget build(BuildContext context) {
  return Center(
    child: Column(
      children: <Widget>[
        Text('Ordenes pendientes'), 
        _listaOps()],),
  );
 }
}