import 'package:flutter/material.dart';
import 'package:sispromovil/models/NotificacionesModel.dart';
import 'package:intl/intl.dart';
import 'package:sispromovil/providers/NotificacionesProvider.dart';

import 'package:sispromovil/providers/PlantaProvider.dart';
import 'package:sispromovil/repositories/notificaciones/Notificaciones_Repository.dart';
import 'package:sispromovil/widgets/shared/PullToRefreshImage.dart';

class Notificaciones extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Notificaciones();
}

class _Notificaciones extends State<Notificaciones> {
  NotificacionesRepository _repoNotificaciones = NotificacionesRepository();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  Widget _buildListaNotificaciones(NotificacionesModel notif, NotificacionesProvider np, String url) {
    return ListView.builder(
      itemCount: notif.data.length,
      itemBuilder: (context, index) {
        var notificacion = notif.data[index];
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
                    '${DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.parse(notificacion.fechaHora))}',
                    style: TextStyle(fontSize: 11),),
                  Text(
                    ' - ${notificacion.maquina}',
                    style: TextStyle(fontSize: 11)
                  ),
                  Text(
                    ' - ${notificacion.id} - ',
                    style: TextStyle(fontSize: 11)
                  ),
                  Text(
                    '${notificacion.subId}',
                    style: TextStyle(fontSize: 11)
                  )
                ],
              ),
              trailing: IconButton(
                splashColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.delete, ),
                onPressed: () {
                  _repoNotificaciones.marcar('$url/notificaciones', notificacion.codigo.toString());
                  np.getNotificacionesAPI();
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
    PlantaProvider pp = Provider.of<PlantaProvider>(context);
    NotificacionesProvider np = Provider.of<NotificacionesProvider>(context);
    

    return Scaffold(
      appBar: AppBar(        
        title: RichText(
            text: TextSpan(
              text: 'Sispro Mobile \n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(text: '${pp.getPlanta.planta}', style: TextStyle(fontSize: 12)),
              ],
            ),
            maxLines: 2,
          ),  
        actions: <Widget>[
          GestureDetector(
            child: Icon(Icons.access_time, color: Theme.of(context).primaryColor,),
            onDoubleTap: () {
              print('desde notificaciones on long press');
              _repoNotificaciones.desmarcarTodas('${pp.getPlanta.servidor}/desmarcarNotificaciones');
              np.getNotificacionesAPI();
            },
          ),
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
                child: Text('${np.cantNotificaciones}')
              )
            ),
          )
        ],      
      ),
      body: np.isLoading ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
          onRefresh: np.getNotificacionesAPI,
          child: np.hasData
          ? _buildListaNotificaciones(np.getNotificaciones, np, pp.getPlanta.servidor)
          : ListView(
            children: <Widget>[
              PullToRefreshImage(texto: 'notificaciones')
            ],
          ),
        )
    );  
  }

}

