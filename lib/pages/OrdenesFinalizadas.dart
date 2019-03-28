import 'package:flutter/material.dart';
import 'package:sispromovil/config/config.dart';
import 'package:sispromovil/models/FinalizadasModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sispromovil/pages/OTFinalizada.dart';

String urlBase = '${Config.baseUrl}/finalizadas';


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

  @override
  void initState() {
    super.initState();
    _obtenerFinalizadas();
  }

  void _obtenerFinalizadas() async {
    var response = await http.get('$urlBase?desde=$desdeItem&cantRegistros=$cantRegistros');
    
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
      });
    } else {
      print('error');
    }
      
  }

  Widget _listaOTSFinalizadas() {
    return totalItems > 0 
    ? Flexible(
      child: ListView.builder(
        itemCount: itemsFinalizados.data.length,
        itemBuilder: (BuildContext context, int index) {
          print('Parcial items: ');
          // print(itemsFinalizados.data[index]);
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
                  builder: (context) => OTFinalizada(id: itemsFinalizados.data[index].id, subID: itemsFinalizados.data[index].subId)
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
                                Text('OT: ${itemsFinalizados.data[index].id}  SUBID: ${itemsFinalizados.data[index].subId}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                                Text('${itemsFinalizados.data[index].cliente}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                Text('${itemsFinalizados.data[index].trabajo}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                                Row(
                                  children: <Widget>[
                                    Text('Inicio OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    Text('${itemsFinalizados.data[index].inicioOt}', style: TextStyle(fontSize: 12))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Fin OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    Text('${itemsFinalizados.data[index].finOt}', style: TextStyle(fontSize: 12))
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
    );
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
                  'Ordenes Finalizadas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                flex: 18,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  parcialItems.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
              )
            ],
          ),
        ),
        _listaOTSFinalizadas()
      ],
    );
  }
}