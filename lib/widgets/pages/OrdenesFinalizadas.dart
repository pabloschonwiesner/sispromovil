import 'package:flutter/material.dart';
import 'package:sispromovil/config/config.dart';
import 'package:sispromovil/models/FinalizadasModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sispromovil/widgets/pages/OTFinalizada.dart';
import 'package:intl/intl.dart';
import 'package:sispromovil/blocs/plantas/BlocPlanta.dart';

// String urlBase = '${Config.baseUrl}/finalizadas';


class OrdenesFinalizadas extends StatefulWidget {
  static const String routeName = '/finalizadas';

  @override
  _OrdenesFinalizadas createState() => _OrdenesFinalizadas();
}

class _OrdenesFinalizadas extends State<OrdenesFinalizadas> {
  int totalItems = 0;
  int parcialItems = 0;
  int desdeItem = 1;
  int cantRegistros = 30;
  FinalizadasModel itemsFinalizados;
  var client = http.Client();
  String baseUrl;
  String plantaAnterior;
  String plantaActual;

  @override
  void initState() {
    super.initState();
    blocPlanta.servidor.listen((servidor) {
      baseUrl = servidor + '/finalizadas';
      plantaActual = servidor;
      _obtenerFinalizadas();
    });
  }

  @override
  void dispose() {
    super.dispose();
    client.close();
    blocPlanta.servidor.drain();
  }

  void _obtenerFinalizadas() async {
    var response = await client.get('$baseUrl?desde=$desdeItem&cantRegistros=$cantRegistros');
    if(plantaAnterior != plantaActual) {
      itemsFinalizados = null;
      totalItems = 0;
      parcialItems = 0;
    }

    if(response.statusCode == 200) {
      setState(() {
        var decodeJson = jsonDecode(response.body);
        if(itemsFinalizados == null) {
          itemsFinalizados = FinalizadasModel.fromJson(decodeJson);
          print(itemsFinalizados.totalRegistros);
          totalItems = itemsFinalizados.totalRegistros;
        } else {
          itemsFinalizados.data.addAll(FinalizadasModel.fromJson(decodeJson).data);
        }
        parcialItems = itemsFinalizados.data.length;
        plantaAnterior = plantaActual;
      });
    } else {
      print('error');
    }
      
  }

  Widget _listaOTSFinalizadas() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        totalItems > 0 
        ? Flexible(
          child: ListView.builder(
            itemCount: itemsFinalizados.data.length,
            itemBuilder: (BuildContext context, int index) {
              var ot = itemsFinalizados.data[index];
              if(index == parcialItems -1) {
                desdeItem = parcialItems;
                _obtenerFinalizadas();
                if(index < totalItems) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              } else {
                return GestureDetector(
                  onTap: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OTFinalizada(id: ot.id, subID: ot.subId)
                    ));
                  },
                  child: Card(
                    margin: EdgeInsets.fromLTRB(4,4,4,15),
                    elevation: 15,
                    child: Container(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 4, 4, 5),
                                child: Column(                      
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[                     
                                    Text('OT: ${ot.id}  SubOT: ${ot.subId}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                                    Text('${ot.cliente}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                    Text('${ot.cantidadProducto} un -${ot.trabajo}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
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
                                    Row(
                                      children: <Widget>[
                                        Text('Inicio OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                        Text('${DateFormat('dd/MM/yyyy hh:mm').format(DateTime.parse(ot.inicioOt))}', style: TextStyle(fontSize: 12))
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Fin OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                        Text('${DateFormat('dd/MM/yyyy hh:mm').format(DateTime.parse(ot.finOt))}', style: TextStyle(fontSize: 12))
                                      ],
                                    ),
                                    
                                  ],
                                ),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                );
              }
            })
          )
        : Center(
          child: CircularProgressIndicator(),
        )        
      ]
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return _listaOTSFinalizadas();
  }
}