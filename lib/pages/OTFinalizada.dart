import 'package:flutter/material.dart';

class OTFinalizada extends StatefulWidget {
  String id;
  String subID;
  OTFinalizada({this.id, this.subID});

  @override
  _OTFinalizada createState() => _OTFinalizada();
}

class _OTFinalizada extends State<OTFinalizada> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sispro Mobil')
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Resumen OT: ${widget.id}',
                    style:TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )            
          )
        ),
      )
    );
  }
}