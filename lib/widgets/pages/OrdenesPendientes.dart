import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sispromovil/models/PendientesModel.dart';
import 'package:intl/intl.dart';
import 'package:sispromovil/widgets/pages/DetalleOT.dart';
import 'package:sispromovil/blocs/ordenesPendientes/BlocOTPendientes.dart';
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
  String plantaAnterior;
  String plantaActual;
  var client = http.Client();
  bool isLoading = false;
  String url;

  @override
  void initState() { 
    super.initState();
    // isLoading = true;
    blocPlanta.llenarListaPlantas();
    blocOTPendientes.llenarListaOTPendientes();
    // isLoading = false;
    // blocOTPendientes.url.listen((url) {
    //   url = url;
    //   if(url != null && url.isNotEmpty) {
    //   }
    // });
    // blocOTPendientes.isLoading.listen((isLoading) => isLoading = isLoading);
    // blocOTPendientes.parcialItems.listen((parcialItems) => parcialItems = parcialItems);
    // blocOTPendientes.listaOTPendientes.listen((lista) => totalItems = lista.totalRegistros);

  }

  
  @override
  void dispose() {
    // blocOTPendientes.url.drain();
    // blocOTPendientes.isLoading.drain();
    // blocOTPendientes.parcialItems.drain();
    // blocOTPendientes.listaOTPendientes.drain();
    super.dispose();
  }


  // void _obtenerPendientes() async {    
  //   if(plantaAnterior != plantaActual) {
  //     setState(() {
  //       itemsPendientes = null;
  //       parcialItems = 0;
  //     });
  //   }

  //   if(mounted == true) {
  //     setState(() {
  //       isLoading = true; 
  //       itemsPendientes = null;  
  //     });
  //   }
  //   var response = await client.get(_url);  
  //   if(response.statusCode == 200 && mounted) {
  //     setState(() {        
  //       var decodeJson = jsonDecode(response.body);
  //       if(itemsPendientes == null) {
  //         itemsPendientes = PendientesModel.fromJson(decodeJson);
  //         totalItems = itemsPendientes.totalRegistros;
  //       } else {
  //         itemsPendientes.data.addAll(PendientesModel.fromJson(decodeJson).data);
  //       }
  //       parcialItems = itemsPendientes.data == null ? 0 : itemsPendientes.data.length;
  //       plantaAnterior = plantaActual;
  //       isLoading = false; 
  //     });
  //   } else {
  //     print('error');
  //   }     
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        isLoading == false
        ? Flexible(
          child: StreamBuilder<Object>(
            stream: blocOTPendientes.listaOTPendientes,
            builder: (context, snapshot) {
              if(snapshot.hasData) { 
                print('Data: ${snapshot.data}');
                PendientesModel listaPendientes = snapshot.data;
                return ListView.builder(
                  // itemCount: parcialItems,
                  itemBuilder: (BuildContext context, int index) {
                    // if(itemsPendientes == null) {
                    //   return Container(width: 0, height: 0,);
                    // }
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
        
  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       isLoading == false
  //       ? Flexible(
  //         child: ListView.builder(
  //           itemCount: parcialItems,
  //           itemBuilder: (BuildContext context, int index) {
  //             // if(itemsPendientes == null) {
  //             //   return Container(width: 0, height: 0,);
  //             // }
  //             var ot = itemsPendientes.data[index];
  //             if(index == parcialItems -1 && mounted) {
  //                desdeItem = parcialItems; 
  //               _obtenerPendientes();
  //               if(index < totalItems) {
  //                 return Center(
  //                   child: CircularProgressIndicator(),
  //                 );
  //               }
  //             } else {
  //               return GestureDetector(
  //                 onTap: () { Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => DetalleOT(id: ot.id, subID: ot.subId, cliente: ot.cliente, producto: ot.trabajo, cantPedida: ot.cantidadProducto, fechaOT: ot.fechaOT, fechaEntrega: ot.fechaEntrega)
  //                   ));
  //                 },
  //                 child: Card(      
  //                   elevation: 10,
  //                   margin: EdgeInsets.fromLTRB(4, 6, 4, 6),
  //                   child: Padding(
  //                     padding: EdgeInsets.all(6),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Text('OT: ${ot.id}  SubOT: ${ot.subId}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
  //                         Text('${ot.cliente}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
  //                         Text(
  //                           '${ot.cantidadProducto} un - ${ot.trabajo}', 
  //                           textAlign: TextAlign.start, 
  //                           overflow: TextOverflow.ellipsis, 
  //                           style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
  //                           maxLines: 2),
  //                         Row(
  //                           children: <Widget>[
  //                             Text('Fecha OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
  //                             Text(
  //                               '${DateFormat('dd/MM/yyyy').format(DateTime.parse(ot.fechaOT))}',
  //                               style: TextStyle(fontSize: 12)
  //                             ),
  //                             Text('   Fecha Ent: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
  //                             Text(
  //                               '${DateFormat('dd/MM/yyyy').format(DateTime.parse(ot.fechaEntrega))}',
  //                               style: TextStyle(fontSize: 12),)
  //                           ],
  //                         ),                          
  //                       ],
  //                     )
  //                   )
  //                 )
  //               );
  //             }
  //           }
  //         )
  //       )
  //       : Center(child: CircularProgressIndicator())
  //     ],
  //   );
  // }





//  @override
//  Widget build(BuildContext context) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         parcialItems > 0
//         ? Flexible(
//           child: ListView.builder(
//             itemCount: parcialItems > totalItems ? totalItems : parcialItems,
//             itemBuilder: (BuildContext context, int index) {
//               if(itemsPendientes == null) {
//                 return Container(width: 0, height: 0,);
//               }
//               var ot =itemsPendientes.data[index];
//               if(index == parcialItems -1 && filtroBusq.isEmpty) {
//                 setState(() {
//                  desdeItem = parcialItems; 
//                 });
//                 _obtenerPendientes();
//                 if(index < totalItems) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               } else {
//                 return GestureDetector(
//                   onTap: () { Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DetalleOT(id: ot.id, subID: ot.subId, cliente: ot.cliente, producto: ot.trabajo, cantPedida: ot.cantidadProducto, fechaOT: ot.fechaOT, fechaEntrega: ot.fechaEntrega)
//                     ));
//                   },
//                   child: Card(      
//                     elevation: 10,
//                     margin: EdgeInsets.fromLTRB(4, 6, 4, 6),
//                     child: Padding(
//                       padding: EdgeInsets.all(6),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text('OT: ${ot.id}  SubOT: ${ot.subId}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
//                             Text('${ot.cliente}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
//                             Text(
//                               '${ot.cantidadProducto} un - ${ot.trabajo}', 
//                               textAlign: TextAlign.start, 
//                               overflow: TextOverflow.ellipsis, 
//                               style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
//                               maxLines: 2),
//                             Row(
//                               children: <Widget>[
//                                 Text('Fecha OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
//                                 Text(
//                                   '${DateFormat('dd/MM/yyyy').format(DateTime.parse(ot.fechaOT))}',
//                                   style: TextStyle(fontSize: 12)
//                                 ),
//                                 Text('   Fecha Ent: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
//                                 Text(
//                                   '${DateFormat('dd/MM/yyyy').format(DateTime.parse(ot.fechaEntrega))}',
//                                   style: TextStyle(fontSize: 12),)
//                               ],
//                             ),
                            
//                           ],
//                         )
//                       )
//                     )
//                 );
//               }
//             }
//           )
//         )
//         : parcialItems > 0
//         ? Center(child: CircularProgressIndicator())
//         : Container(width: 0, height: 0)
//       ],
//     );
//  }
}