import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:sispromovil/models/NotificacionesModel.dart';
import 'package:sispromovil/blocs/notificaciones/BlocNotificaciones.dart';
import 'package:sispromovil/blocs/plantas/BlocPlanta.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Notificaciones extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Notificaciones();
}

class _Notificaciones extends State<Notificaciones> {
  Client client = Client();
  String url;
  final _saved = Set<String>();
  Timer _timer;


  @override
  void dispose() {
    super.dispose();
    client.close();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    blocNotificaciones.initialData();
  }

  Widget _buildListaNotificaciones(NotificacionesModel notif) {
    return ListView.builder(
      itemCount: notif.data.length,
      itemBuilder: (context, index) {
        var notificacion = notif.data[index];
        _saved.add(notificacion.codigo.toString());
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(
                notif.data[index].mensaje,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
              ),
              subtitle: Row(
                children: <Widget>[
                  Text(
                    '${DateFormat('dd/MM/yyyy hh:mm:ss').format(DateTime.parse(notif.data[index].fechaHora))}',
                    style: TextStyle(fontSize: 11),),
                  Text(
                    ' - ${notif.data[index].maquina}',
                    style: TextStyle(fontSize: 11)
                  ),
                  Text(
                    ' - ${notif.data[index].id} - ',
                    style: TextStyle(fontSize: 11)
                  ),
                  Text(
                    '${notif.data[index].subId}',
                    style: TextStyle(fontSize: 11)
                  )
                ],
              ),
              trailing: IconButton(
                splashColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.delete, ),
                onPressed: () {
                  blocNotificaciones.marcar(notif.data[index].codigo.toString());
                }
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider()
            )
          ],
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
              return Text('Sispro Mobile');
            }            
          },
        ),  
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(35)
              ),
              child: Center(
                child: StreamBuilder(
                  stream: blocNotificaciones.cantidadNotificaciones,
                  builder: (context, snapshot) {
                    if(snapshot.hasData && snapshot.data > 0){
                      return Text(
                        snapshot.data.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold), 
                        textAlign: TextAlign.center,
                      );
                    } else {
                      return Text(
                        '0',
                        style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold), 
                        textAlign: TextAlign.center,
                      );
                    }
                  },
                )
              )
            ),
          )
        ],      
      ),
      body: StreamBuilder(
        stream: blocNotificaciones.notificaciones,
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _buildListaNotificaciones(snapshot.data);
          }
        },
      )
    );  
  }

}

