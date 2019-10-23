import 'package:flutter/material.dart';

class PullToRefreshImage extends StatelessWidget {
  final String texto;

  PullToRefreshImage({this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 100,),
          Icon(Icons.system_update_alt, size: 150, color: Colors.grey[500],),
          Text('No hay ${this.texto} para mostrar.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[500],)),
          Text('Tire hacia abajo para refrescar.', style: TextStyle(fontSize: 14))
        ],
      )
    );
  }
}