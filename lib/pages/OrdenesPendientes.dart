import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sispromovil/models/PendientesModel.dart';
import 'package:sispromovil/components/PanelOTPendiente.dart';

const baseUrl = 'http://10.0.3.2:3002/pendientes';
// const baseUrl = 'http://192.168.1.71:3002/pendientes';
// const baseUrl = 'http://192.168.0.9:3002/pendientes';

class OrdenesPendientes extends StatefulWidget {
  static const String routeName = '/pendientes';
  @override
  _OrdenesPendientes createState() => _OrdenesPendientes();
  }
  

class _OrdenesPendientes extends State<OrdenesPendientes> {
  PendientesModel itemsPendientes;
  int totalItems = 0;
  int parcialItems = 0;
  int desdeItem = 1;
  int cantRegistros = 30;

  @override
  void initState() {
    super.initState();
    _obtenerPendientes();
  }

  void _obtenerPendientes() async {
    var response = await http.get('$baseUrl?desde=$desdeItem&cantRegistros=$cantRegistros');
    if(response.statusCode == 200) {
      setState(() {
        var decodeJson = jsonDecode(response.body);
        if(itemsPendientes == null) {
          itemsPendientes = PendientesModel.fromJson(decodeJson);
          totalItems = itemsPendientes.totalRegistros;
        } else {
          itemsPendientes.data.addAll(PendientesModel.fromJson(decodeJson).data);
        }
        parcialItems = itemsPendientes.data.length;
      });
    } else {
      print('error');
    }    
  }

        
 @override
 Widget build(BuildContext context) {
  return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Ordenes pendientes', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,                    
                  ),
                  textAlign: TextAlign.center,
                ), 
                flex: 17,
              ),
              Expanded(child: Text('${parcialItems > totalItems ? totalItems :parcialItems}/$totalItems', style: TextStyle(fontSize: 10),), flex: 3,)
            ],
          )         
        ),
          Flexible(
            child: ListView.builder(
              itemCount: parcialItems > totalItems ? totalItems : parcialItems,
              itemBuilder: (BuildContext context, int index) {
                if(index == parcialItems -1) {
                  desdeItem = parcialItems;
                  _obtenerPendientes();
                  if(index < totalItems) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                } else {
                  return PanelOTPendiente(itemsPendientes.data[index]);
                }
              }
            )
          ),        
      ],
    );
 }
}