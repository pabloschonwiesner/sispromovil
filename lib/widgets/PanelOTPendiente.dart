import 'package:flutter/material.dart';
import 'package:sispromovil/models/PendientesModel.dart';
import 'package:intl/intl.dart';

class PanelOTPendiente extends StatefulWidget {
  Data ot;
  PanelOTPendiente(this.ot);

  @override
  _PanelOTPendiente createState() => _PanelOTPendiente();
}

class _PanelOTPendiente extends State<PanelOTPendiente> {  
  // Data ot;
  final double heightHeader = 57;
  final double heigtheightAll = 150;
  double height = 0;

  // _PanelOTPendiente({this.ot});

  @override
  void initState() {
    super.initState();
    height = heightHeader;
  }

  Widget _ots () {
    if(height > 100) {
      return Column(
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(child: Text('OT: ${widget.ot.id}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
          ],),
          Row(children: <Widget>[
            Expanded(child: Text('Cliente: ${widget.ot.cliente}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
          ],),
          Row(children: <Widget>[
            Expanded(child: Text(widget.ot.trabajo, overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 12))),              
          ],),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Row(children: <Widget>[
                  Expanded(child: Text('Vendedor: ${widget.ot.vendedor}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 12))),
                ],),
                Row(children: <Widget>[
                  Expanded(child: Text('Cantidad: ${widget.ot.cantBuenasProg}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 12))),
                ],),
                Row(children: <Widget>[
                  Expanded(child: Text('Fecha: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.ot.fecha))}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 12))),
                ],),
                Row(children: <Widget>[
                  Expanded(child: Text('Fecha entrega: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.ot.fechaEntrega))}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 12))),
                ],),
              ],
            ),
          ),
          Divider(
              color: Colors.grey[500],
              height: 2,
            ) 
            
        ],
      );
    } else {
      return Column(          
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(child: Text('OT: ${widget.ot.id}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
            ],),
            Row(children: <Widget>[
              Expanded(child: Text('Cliente: ${widget.ot.cliente}', overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
            ],),
            Row(children: <Widget>[
              Expanded(child: Text(widget.ot.trabajo, overflow: TextOverflow.ellipsis, style:TextStyle(fontSize: 12))),              
            ],),
            
            Divider(
                color: Colors.grey[500],
                height: 2,
              )        
          ],       
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.grey[200],
        height: height,
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: _ots(),      
      ),
      onTap: () {
        setState(() {
          height = height == heightHeader ? heigtheightAll : heightHeader;
        });          
      },
    );   
  }
}
