import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sispromovil/models/PendientesModel.dart';
import 'package:intl/intl.dart';
import 'package:sispromovil/blocs/plantas/BlocPlanta.dart';

class OrdenesPendientes extends StatefulWidget {
  static const String routeName = '/pendientes';
  
  @override
  _OrdenesPendientes createState() =>_OrdenesPendientes();    
}  

class _OrdenesPendientes extends State<OrdenesPendientes> {
  PendientesModel itemsPendientes;
  int totalItems = 0;
  int parcialItems = 0;
  int desdeItem = 1;
  int cantRegistros = 30;
  String baseUrl;
  String plantaAnterior;
  String plantaActual;
  var client = http.Client();

  @override
  void initState() { 
    super.initState();
    blocPlanta.servidor.listen((servidor) {
      baseUrl = servidor + '/pendientes';
      plantaActual = servidor;
      _obtenerPendientes();
    });
  }

  @override
  void dispose() {
    super.dispose();
    client.close();
    blocPlanta.servidor.drain();
  }

  void _obtenerPendientes() async {    
    print('BaseUrl $baseUrl');
    if(plantaAnterior != plantaActual) {
      itemsPendientes = null;
      parcialItems = 0;
      totalItems = 0;
    }
    String url = '$baseUrl?desde=$desdeItem&cantRegistros=$cantRegistros';
    var response = await client.get(url);    
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
        plantaAnterior = plantaActual;
      });
    } else {
      print('error');
    }    
  }
        
 @override
 Widget build(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        parcialItems > 0
        ? Flexible(
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
        )
        : Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
 }
}