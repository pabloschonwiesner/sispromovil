import 'package:flutter/material.dart';
import 'package:sispromovil/models/EnCursoModel.dart';
import 'package:intl/intl.dart';
import 'package:sispromovil/widgets/pages/DetalleOT.dart';
import 'package:sispromovil/blocs/ordenesEnCurso/BlocOTEnCurso.dart';

class OrdenesEnCurso extends StatefulWidget {
  static const String routeName = '/enCurso';
  @override
  _OrdenesEnCurso createState() => _OrdenesEnCurso();
}

class _OrdenesEnCurso extends State<OrdenesEnCurso> {

  @override 
  void initState() {
    blocEnCurso.initialData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _hsSexagesimales(double hs) {
    var minutos = ((hs - hs.floor()) * 60).round();
    String strMinutos = '';
    minutos<10 ? strMinutos = '0' + minutos.toString() :strMinutos =minutos.toString();
    return hs.floor().toString() + ':' + strMinutos; 
  }

  Widget _listaRecursos(EnCursoModel itemsEnCurso) {
    double anchoPantalla = MediaQuery.of(context).size.width;
    return  Center(
      child: ListView.builder(
        itemCount: itemsEnCurso.data.length,
        itemBuilder: (BuildContext context, int index) {
          var recurso = itemsEnCurso.data[index];
          return GestureDetector(
            onTap: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleOT(id: recurso.id, subID: recurso.subId, cliente: recurso.descripcionCliente, producto: recurso.trabajo, cantPedida: recurso.cantidadProducto, fechaOT: recurso.fechaOT, fechaEntrega: recurso.fechaEntrega)
                    ));
            },
            child: Card(
              margin: EdgeInsets.fromLTRB(4,4,4,15),
              elevation: 10,
              child: Container(
                height: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(
                          color: Color.fromRGBO(recurso.red,recurso.green,recurso.blue,1.0),
                          width: 10
                        )),
                      ),
                      height: 130
                    ),
                    Container(
                      child: Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 4, 4, 5),
                          child: Column(                      
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1),
                                child: Text('${recurso.descRecurso}', style:TextStyle(color: Theme.of(context).primaryColor)),
                              ),                          
                              Text('OT: ${recurso.id}  SubOT: ${recurso.subId}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                              Text('${recurso.descripcionCliente}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                              Text('${recurso.cantidadProducto} un - ${recurso.trabajo}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic), maxLines: 2,),
                              Row(
                                children: <Widget>[
                                  Text('Fecha OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  Text(
                                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse(recurso.fechaOT))}',
                                    style: TextStyle(fontSize: 12)
                                  ),
                                  Text('   Fecha Ent: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  Text(
                                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse(recurso.fechaEntrega))}',
                                    style: TextStyle(fontSize: 12),)
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Cant Prog: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  Text('${recurso.cantBuenosProg.floor()}', style: TextStyle(fontSize: 12)),
                                  Text('    Hs Prog: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  Text('${recurso.cantidadHorasProgTotales > 0 ? _hsSexagesimales(recurso.cantidadHorasProgTotales) : _hsSexagesimales(recurso.horasBarra)}', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Cant Producida: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  Text('${recurso.cantidadBuenos.round()}', style: TextStyle(fontSize: 12))
                                ],
                              )
                            ],
                          ),
                        )
                      ),
                    ),
                    Container(
                      width: anchoPantalla * 0.14,
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[Text('${recurso.porcAvance.floor()} %', style: TextStyle(fontWeight: FontWeight.bold),)],
                      ),
                    )
                  ],
                ),
              )
            ),
          );
        }
      )
    );
  }

 @override
 Widget build(BuildContext context) {   
  return StreamBuilder(
    stream: blocEnCurso.enCursoFiltradas,
    builder: (context, snapshot) {
      if(!snapshot.hasData) {
        return Container(
          child: Center(
            child: CircularProgressIndicator()
          )
        );
      } else {
        return Column(
          children: <Widget>[
            Flexible(
              child: _listaRecursos(snapshot.data)       
            )
          ],
        );
      }
    },
  );
 }
}

  