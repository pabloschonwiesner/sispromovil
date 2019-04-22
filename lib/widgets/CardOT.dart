import 'package:flutter/material.dart';
import 'package:sispromovil/models/Ot.dart';
import 'package:intl/intl.dart';

class CardOT extends StatefulWidget {
  Ots ot;
  CardOT(this.ot);

  @override
  _CardOT createState() => _CardOT();
}

class _CardOT extends State<CardOT> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(      
      elevation: 10,
      margin: EdgeInsets.fromLTRB(2, 4, 2, 4),
      child: Padding(
        padding: EdgeInsets.fromLTRB(6,3,6,3),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('OT: ${widget.ot.id}  SubOT: ${widget.ot.subId}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              Text('${widget.ot.cliente}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              Text(
                '${widget.ot.cantidadProducto} un - ${widget.ot.trabajo}', 
                textAlign: TextAlign.start, 
                overflow: TextOverflow.ellipsis, 
                style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                maxLines: 2),
              Row(
                children: <Widget>[
                  Text('Fecha OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.ot.fechaOT))}',
                    style: TextStyle(fontSize: 12)
                  ),
                  Text('   Fecha Ent: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.ot.fechaEntrega))}',
                    style: TextStyle(fontSize: 12),)
                ],
              ),
              
            ],
          )
        )
      );
  }
}