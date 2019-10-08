import 'package:flutter/material.dart';
import 'package:sispromovil/models/PendientesPlanificadasModel.dart';
import 'package:intl/intl.dart';
import 'package:sispromovil/blocs/ordenesPendientesPlanificadas/BlocOTPendientesPlanificadas.dart';
import 'package:sispromovil/widgets/pages/DetalleOT.dart';

class OrdenesPendientesPlanificadas extends StatefulWidget {
  static const String routeName = '/pendientesPlanificadas';
  @override
  _OrdenesPendientesPlanificadas createState() => _OrdenesPendientesPlanificadas();
}

class _OrdenesPendientesPlanificadas extends State<OrdenesPendientesPlanificadas> {

  @override
  void initState() {
    blocPendientesPlanificadas.initialData();
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


  //con card
  Widget _itemOT(Ots ot) {
    double anchoPantalla = MediaQuery.of(context).size.width;
    return Container(
      width: anchoPantalla * 0.8 * MediaQuery.of(context).textScaleFactor,
      child: ot.id != '' 
        ? GestureDetector(
          onTap: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleOT(id: ot.id, subID: ot.subId, cliente: ot.cliente, producto: ot.trabajo, cantPedida: ot.cantidadProducto, fechaOT: ot.fechaOT, fechaEntrega: ot.fechaEntrega)
                    ));
          },
          child: Card(      
            elevation: 10,
            margin: EdgeInsets.fromLTRB(2, 4, 2, 4),
            child: Padding(
              // padding: EdgeInsets.fromLTRB(6,3,6,3),
              padding: EdgeInsets.fromLTRB(6,3,6,3),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('OT: ${ot.id}  SubOT: ${ot.subId}', maxLines: 1, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    Text('${ot.cliente}', maxLines: 1, textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    Text(
                      '${ot.cantidadProducto} un - ${ot.trabajo}', 
                      textAlign: TextAlign.start, 
                      overflow: TextOverflow.ellipsis, 
                      style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                      maxLines: 2),
                    Row(
                      children: <Widget>[
                        Text('Fecha OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
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
                        Text('Inicio: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text('${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(ot.fechaInicio))}', style: TextStyle(fontSize: 12)),
                        Text('    Hs Prog: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text('${_hsSexagesimales(ot.horasTotales)}', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Cant Prog: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text('${ot.cantBuenasProg.floor()}', style: TextStyle(fontSize: 12)),
                      ],
                    )
                  ],
                )
              )
            ),
        )
          : Card(  
            color: Color(0x44888888), 
            elevation: 10,
            margin: EdgeInsets.fromLTRB(2, 4, 2, 4),
            child: Padding(
              padding: EdgeInsets.fromLTRB(6,3,6,3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('ASIGNADO A RECURSO', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Inicio: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10), ),
                      Text('${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(ot.fechaInicio))}', style: TextStyle(fontSize: 10)),
                      Text('   Fin: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                      Text('${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(ot.fechaFin))}', style: TextStyle(fontSize: 10)),
                    ],
                  )
                ],
              )
            )
          )
    );
  }

  Widget _listaTrabajos(Data recurso) {
    double alto = MediaQuery.of(context).textScaleFactor > 1 ? 160 * MediaQuery.of(context).textScaleFactor : 160 ;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      height: alto,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey[400]))
      ),
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(recurso.maquina, style:TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Theme.of(context).primaryColor), textAlign: TextAlign.start,),
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recurso.ots.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(0,4,4,4),
                    child: _itemOT(recurso.ots[index])
                  );
                },
              )
            )            
          ],
        ),
      )
    );
  }


  Widget _listaRecursos(PendientesPlanificadasModel itemsPendientesPlanificadas) {
    return ListView(
      children: itemsPendientesPlanificadas.data.map((recurso) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: _listaTrabajos(recurso)
        )).toList()
      );      
  }

  @override
 Widget build(BuildContext context) {
  return StreamBuilder(
    stream: blocPendientesPlanificadas.pendientesFiltradas,
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
              child: _listaRecursos(snapshot.data),
            )
          ],
        );
      }
    }
  );
 }
}