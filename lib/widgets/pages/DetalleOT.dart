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
  int _cantChecks = 0;
  int _cantGeop = 0;
  ChecksModel _detalleChecks;
  
  
  @override
  void initState() {
    blocPlanta.servidor.listen((servidor) {
      print('Servidor desde detalleOT: $servidor');
      setState(() {
        baseUrl = servidor + '/detalle';
      });
      _listaDetalleOT();
    });
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  // Future<ChecksModel> _listaDetalleOT() async { 
  //   if(baseUrl != null) {
  //     var response = await http.get('$baseUrl?ot=${widget.id}&subot=${widget.subID}');
  //     if(response.statusCode == 200 && mounted) {
  //       _detalleChecks = ChecksModel.fromJson(json.decode(response.body));
  //       setState(() {
  //         _cantChecks = _detalleChecks.data[0].checkList.length;
  //         _cantGeop = _detalleChecks.data[0].geop.length;
  //       });
  //     } else {
  //       _detalleChecks = ChecksModel();
  //     }
  //     return _detalleChecks;
  //   }    
  // }

  Future<ChecksModel> _listaDetalleOT() async { 
    if(baseUrl != null) {
      var response = await http.get('$baseUrl?ot=${widget.id}&subot=${widget.subID}');
      if(response.statusCode == 200 && mounted) {
        _detalleChecks = ChecksModel.fromJson(json.decode(response.body));
        setState(() {
          _cantChecks = _detalleChecks.data[0].checkList.length;
          _cantGeop = _detalleChecks.data[0].geop.length;
        });
      } else {
        _detalleChecks = ChecksModel();
      }
      return _detalleChecks;
    }    
  }

  Widget _buildDetalleOT() {
    return FutureBuilder(
      future: _listaDetalleOT(),
      builder: (context, snapshot) {
        return Padding(
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
                      '${widget.fechaOT.isEmpty ? '' : DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.fechaOT))}',
                      style: TextStyle(fontSize: 12)
                    ),
                    Text('   Fecha Ent: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text(
                      '${widget.fechaEntrega.isEmpty ? '' : DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.fechaEntrega))}',
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
                  itemCount: _cantChecks,
                  itemBuilder: (context, index) {
                    if(snapshot.hasData) {                      
                      ChecksModel datos = snapshot.data;
                      return Padding(
                        padding: EdgeInsets.only(left: 2),
                        child: FilterChip(
                          backgroundColor: datos.data[0].checkList[index].valor == "0" ? Colors.grey[300] : Colors.lightGreenAccent,
                          labelStyle: TextStyle(fontSize: 12, color: Colors.black,),
                          label: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(datos.data[0].checkList[index].clave)),
                          onSelected: (b) {},
                        ));
                    } else {
                      return Center(child: CircularProgressIndicator(),);
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
                  itemCount: _cantGeop,
                  itemBuilder: (context, index) {
                    if(snapshot.data == null) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      ChecksModel datos = snapshot.data;
                      return  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: '${datos.data[0].geop[index].clave}:   ',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),                            
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${datos.data[0].geop[index].valor}',
                                  style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.normal)
                                )
                              ]
                            )
                          )
                        ],
                      );
                    }                  
                  },
                ),
              )
            ],
          ),
        );
      },
    );
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
              return CircularProgressIndicator();
            }
            
          },
        ),  
      ),
      body: _buildDetalleOT()
    );
  }
}