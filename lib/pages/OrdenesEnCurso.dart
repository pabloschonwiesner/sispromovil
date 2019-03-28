import 'package:flutter/material.dart';
import 'package:sispromovil/models/EnCursoModel.dart';
import 'package:http/http.dart' as http;
import 'package:sispromovil/config/config.dart';
import 'dart:convert';
import 'dart:async';

const String baseUrl = '${Config.baseUrl}/enProceso';

class OrdenesEnCurso extends StatefulWidget {
  static const String routeName = '/enCurso';
  @override
  _OrdenesEnCurso createState() => _OrdenesEnCurso();
}

class _OrdenesEnCurso extends State<OrdenesEnCurso> {
  int totalItems = 0;
  Duration ms = Duration(milliseconds: 1);
  EnCursoModel itemsEnCurso;
  var timer;

  @override 
  void initState() {
    super.initState();
      _obtenerEnCurso();
      timer = _iniciarTimer(5000);    
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  Timer _iniciarTimer(int milisegundos) {
    var duracion = milisegundos == null ? 30000 : ms * milisegundos;
    return Timer.periodic(duracion, (Timer timer) => _obtenerEnCurso());
  }

  void _obtenerEnCurso() async {
    var response = await http.get('$baseUrl');
    print('peticion realizada');
    if(response.statusCode == 200) {
      setState(() {
        var decodeJson = jsonDecode(response.body);
        itemsEnCurso = EnCursoModel.fromJson(decodeJson);
        totalItems = itemsEnCurso.data.length;
        print('Cant: ${itemsEnCurso.data.length}');
      });      
    } else {
      print('error');
    }


  }

  String _hsSexagesimales(double hs) {
    var minutos = ((hs - hs.floor()) * 60).round();
    String strMinutos = '';
    minutos<10 ? strMinutos = '0' + minutos.toString() :strMinutos =minutos.toString();
    return hs.floor().toString() + ':' + strMinutos; 
  }

  Widget _listaRecursos() {
    double anchoPantalla =MediaQuery.of(context).size.width;
    return totalItems > 0 
    ? Center(
      child: ListView(
        children: itemsEnCurso.data.map((recurso) => Card(
          margin: EdgeInsets.fromLTRB(4,4,4,15),
          elevation: 15,
          child: Container(
            height: 120,
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
                  height: 120
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
                          Text('OT: ${recurso.id}  SUBID: ${recurso.subId}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                          Text('${recurso.descripcionCliente}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                          Text('${recurso.trabajo}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                          Row(
                            children: <Widget>[
                              Text('Cant Prog: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              Text('${recurso.cantBuenosProg}', style: TextStyle(fontSize: 12)),
                              Text('    Hs Total Prog: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              Text('${recurso.cantidadHorasProgTotales > 0 ? _hsSexagesimales(recurso.cantidadHorasProgTotales) : _hsSexagesimales(recurso.horasBarra)}', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text('Cant Buenos: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
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

        )).toList()
      )
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
                'Ordenes en Curso', 
                style: TextStyle(
                  fontWeight: FontWeight.bold,                    
                ),
                textAlign: TextAlign.center,
              ), 
              flex: 17,
            ),
          ],
        )         
      ),
      Flexible(
        child: _listaRecursos()       
      )
    ],
  );
 }
}

  