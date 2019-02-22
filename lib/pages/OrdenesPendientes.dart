import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sispromovil/models/PendientesModel.dart';
import 'package:intl/intl.dart';

const baseUrl = 'http://10.0.3.2:3002/pendientes';

class OrdenesPendientes extends StatefulWidget {
  static const String routeName = '/pendientes';
  @override
  _OrdenesPendientes createState() => _OrdenesPendientes();
  }
  

class _OrdenesPendientes extends State<OrdenesPendientes> {
  PendientesModel itemsPendientes;
  int totalItems = 0;
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
        itemsPendientes == null 
          ? itemsPendientes = PendientesModel.fromJson(decodeJson)
          : itemsPendientes.data.addAll(PendientesModel.fromJson(decodeJson).data);
        // print(itemsPendientes.toJson());
        print('Cantidad: ${itemsPendientes.data.length}');
      });
    } else {
      print('error');
    }    
  }

  Widget _listaOps() => ExpansionPanelList(
    expansionCallback: (int index, bool isExpanded) {
      setState(() {
        itemsPendientes.data[index].isExpanded = !isExpanded;
      });
    },
    children: itemsPendientes.data
        .map<ExpansionPanel>((Data item) => ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Expanded(child: Text('OT: ${item.id}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
                  ],),
                  Row(children: <Widget>[
                    Expanded(child: Text('Cliente: ${item.cliente}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
                  ],),
                  Row(children: <Widget>[
                    Expanded(child: Text(item.trabajo, overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 12)))
                  ],)
                  
                ],
              ),
            );
          },
          isExpanded: item.isExpanded,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  Expanded(child: Text('Vendedor:   ${item.vendedor}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 12)))
                ],),
                Row(children: <Widget>[
                  Expanded(child: Text('Cantidad pedida:   ${item.cantBuenasProg}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 12)))
                ],),
                Row(children: <Widget>[
                  Expanded(child: Text('Fecha ingreso:   ${DateFormat('dd/MM/yyyy').format(DateTime.parse(item.fecha))}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 12)))
                ],),
                Row(children: <Widget>[
                  Expanded(child: Text('Fecha entrega:   ${DateFormat('dd/MM/yyyy').format(DateTime.parse(item.fechaEntrega))}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 12)))
                ],),
                SizedBox(height: 30,)
              ],
            )
          )
        ))
        .toList()     
  );
        
 @override
 Widget build(BuildContext context) {
  return Center(
    child: ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text('Ordenes pendientes', style: TextStyle(fontWeight: FontWeight.bold),)
          ), 
        ),     
        itemsPendientes == null
          ? Row(
              children: <Widget>[Padding(padding: EdgeInsets.only(top: 100), child: CircularProgressIndicator(),)], 
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            )
          : _listaOps()
      ],
    ),
  );
 }
         
  }

