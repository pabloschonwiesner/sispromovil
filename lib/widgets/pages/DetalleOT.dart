import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sispromovil/blocs/plantas/BlocPlanta.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:sispromovil/models/ChecksModel.dart';

class DetalleOT extends StatefulWidget {
  final String id;
  final String subID;
  final String cliente;
  final String producto;
  final int cantPedida;
  final String fechaOT;
  final String fechaEntrega;

  DetalleOT({this.id, this.subID, this.cliente, this.producto, this.cantPedida, this.fechaOT, this.fechaEntrega});

  @override
  _DetalleOT createState() => _DetalleOT();
}

class _DetalleOT extends State<DetalleOT> {
  String baseUrl;
  ChecksModel _detalleChecks;
  
  @override
  void initState() {
    blocPlanta.servidor.listen((servidor) {
      baseUrl = servidor + '/detalle';
      _listaDetalleOT();
    });
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  void _listaDetalleOT() async {
    var response = await http.get('$baseUrl?ot=${widget.id}&subot=${widget.subID}');
    if(response.statusCode == 200) {
      setState(() {
        _detalleChecks = ChecksModel.fromJson(json.decode(response.body));
      });
    } else {
      _detalleChecks = null;
    }
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: blocPlanta.planta,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              return RichText(
                text: TextSpan(
                  text: 'Sispro Mobile \n',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: '${snapshot.data}', style: TextStyle(fontSize: 12)),
                  ],
                ),
                maxLines: 2,
              );
            } else {
              return Text('Sispro Mobile');
            }
            
          },
        ),  
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(            
          children: <Widget>[
            Text('OT: ${widget.id}  SubOT: ${widget.subID}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
              child: Text('${widget.cliente}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
            ),
            Text('${widget.cantPedida} un -${widget.producto}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Fecha OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.fechaOT))}',
                    style: TextStyle(fontSize: 12)
                  ),
                  Text('   Fecha Ent: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.fechaEntrega))}',
                    style: TextStyle(fontSize: 12),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Divider()
            ),
            Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _detalleChecks != null ? _detalleChecks.data[0].checkList.length : 0,
                itemBuilder: (context, index) {
                  if(_detalleChecks == null) {
                    return Center(child: CircularProgressIndicator(),);
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: FilterChip(
                        backgroundColor: _detalleChecks.data[0].checkList[index].valor == "0" ? Colors.grey[300] : Colors.lightGreenAccent,
                        labelStyle: TextStyle(fontSize: 12, color: Colors.black),
                        label: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(_detalleChecks.data[0].checkList[index].clave)),
                        onSelected: (b) {},
                      ));
                  }
                },
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Divider()
            ),
            Flexible(
              flex: 1,
              child: ListView.builder(
                itemCount: _detalleChecks != null ? _detalleChecks.data[0].checkList.length : 0,
                itemBuilder: (context, index) {
                  if(_detalleChecks == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return  Row(
                      children: <Widget>[
                        Text('${_detalleChecks.data[0].geop[index].clave}:   ', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                        Text('${_detalleChecks.data[0].geop[index].valor}', overflow: TextOverflow.ellipsis ,style: TextStyle(fontSize: 14))
                      ],
                    );
                  }                  
                },
              ),
            )
          ],
        ),
      )
    );
  }
}