import 'package:flutter/material.dart';
import 'package:sispromovil/models/FinalizadasModel.dart';
import 'package:sispromovil/widgets/pages/DetalleOT.dart';
import 'package:intl/intl.dart';
import 'package:sispromovil/blocs/ordenesFinalizadas/BlocOTFinalizadas.dart';

class OrdenesFinalizadas extends StatefulWidget {
  static const String routeName = '/finalizadas';

  @override
  _OrdenesFinalizadas createState() => _OrdenesFinalizadas();
}

class _OrdenesFinalizadas extends State<OrdenesFinalizadas> {

  @override
  void initState() {
    blocFinalizadas.initialData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _listaOTSFinalizadas(FinalizadasModel itemsFinalizados) {
    double alto = MediaQuery.of(context).textScaleFactor * 100;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Flexible(
        child: ListView.builder(
          itemCount: itemsFinalizados.data.length,
          itemBuilder: (BuildContext context, int index) {
            var ot = itemsFinalizados.data[index];
              return GestureDetector(
                onTap: () { Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalleOT(id: ot.id, subID: ot.subId, cliente: ot.cliente, producto: ot.trabajo, cantPedida: ot.cantidadProducto, fechaOT: ot.fechaOT, fechaEntrega: ot.fechaEntrega)
                  ));
                },
                child: Card(
                  margin: EdgeInsets.fromLTRB(4,4,4,15),
                  elevation: 15,
                  child: Container(
                    height: alto,
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
                                        '${ot.fechaOT.isEmpty ? '' : DateFormat('dd/MM/yyyy').format(DateTime.parse(ot.fechaOT))}',
                                        style: TextStyle(fontSize: 12)
                                      ),
                                      Text('   Fecha Ent: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                      Text(
                                        '${ot.fechaEntrega.isEmpty ? '' : DateFormat('dd/MM/yyyy').format(DateTime.parse(ot.fechaEntrega))}',
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
            // }
          })
        )      
      ]
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: blocFinalizadas.finalizadasFiltradas,
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        } else {
          return _listaOTSFinalizadas(snapshot.data);
        }
      },
    );
  }
}