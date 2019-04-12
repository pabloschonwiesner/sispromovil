import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sispromovil/models/PendientesModel.dart';
import 'package:intl/intl.dart';
import 'package:sispromovil/config/config.dart';

const baseUrl = '${Config.baseUrl}/pendientes';
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
        Flexible(
          child: ListView.builder(
            itemCount: parcialItems > totalItems ? totalItems : parcialItems,
            itemBuilder: (BuildContext context, int index) {
              var ot =itemsPendientes.data[index];
              if(index == parcialItems -1) {
                desdeItem = parcialItems;
                _obtenerPendientes();
                if(index < totalItems) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              } else {
                return Card(      
                  elevation: 10,
                  margin: EdgeInsets.fromLTRB(4, 6, 4, 6),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('OT: ${ot.id}  SubOT: ${ot.subId}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                          Text('${ot.cliente}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                          Text(
                            '${ot.cantidadProducto} un - ${ot.trabajo}', 
                            textAlign: TextAlign.start, 
                            overflow: TextOverflow.ellipsis, 
                            style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                            maxLines: 2),
                          Row(
                            children: <Widget>[
                              Text('Fecha OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              Text(
                                '${DateFormat('dd/MM/yyyy').format(DateTime.parse(ot.fechaOT))}',
                                style: TextStyle(fontSize: 12)
                              ),
                              Text('   Fecha Ent: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              Text(
                                '${DateFormat('dd/MM/yyyy').format(DateTime.parse(ot.fechaEntrega))}',
                                style: TextStyle(fontSize: 12),)
                            ],
                          ),
                          
                        ],
                      )
                    )
                  );
              }
            }
          )
        ),        
      ],
    );
 }
}