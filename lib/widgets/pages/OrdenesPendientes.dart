import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sispromovil/models/PendientesModel.dart';
import 'package:intl/intl.dart';
import 'package:sispromovil/widgets/pages/DetalleOT.dart';
import 'package:sispromovil/blocs/ordenesPendientes/BlocOTPendientes.dart';

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
  String plantaAnterior;
  String plantaActual;
  var client = http.Client();
  bool isLoading = false;
  String url;

  @override
  void initState() { 
    blocPendientes.initialData();
    super.initState();
  }

  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        isLoading == false
        ? Flexible(
          child: StreamBuilder<Object>(
            stream: blocPendientes.pendientesFiltradas,
            builder: (context, snapshot) {
              if(snapshot.hasData) { 
                // switch(snapshot.connectionState) {
                //   case ConnectionState.none: print('None');
                //   case ConnectionState.waiting: return Text('waiting');
                //   case ConnectionState.active: return Text('active');
                //   case ConnectionState.done: return Text('done');
                // }
                PendientesModel listaPendientes = snapshot.data;
                parcialItems = listaPendientes.data.length;
                return ListView.builder(
                  itemCount: listaPendientes.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var ot = listaPendientes.data[index];
                    // if(index == parcialItems -1 && mounted) {
                    //   desdeItem = blocOTPendientes.changeDesdeItem(parcialItems); 
                    //   blocOTPendientes.llenarListaOTPendientes();
                    //   if(index < totalItems) {
                    //     return Center(
                    //       child: CircularProgressIndicator(),
                    //     );
                    //   }
                    // } else {
                      // if(index >= parcialItems -1) {
                      //   blocPendientes.getOtPendientes(desde: parcialItems);
                      //   parcialItems = listaPendientes.data.length;
                      //   print('Pendientes $parcialItems');
                      // }
                      return GestureDetector(
                        onTap: () { Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalleOT(id: ot.id, subID: ot.subId, cliente: ot.cliente, producto: ot.trabajo, cantPedida: ot.cantidadProducto, fechaOT: ot.fechaOT, fechaEntrega: ot.fechaEntrega)
                          ));
                        },
                        child: Card(      
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
                        )
                      );
                    // }
                  }
                );
              } else {
                return Container();
              }
            }
          )
        )
        : Center(child: CircularProgressIndicator())
      ],
    );
  }      
}