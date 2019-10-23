import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sispromovil/models/BusquedaModel.dart';
import 'package:sispromovil/models/PendientesModel.dart';
import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sispromovil/providers/BusquedaProvider.dart';
import 'package:sispromovil/providers/PlantaProvider.dart';
import 'package:sispromovil/widgets/pages/DetalleOT.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository.dart';
import 'package:sispromovil/repositories/otPendientes/OT_Pendientes_Repository.dart';
import 'package:sispromovil/widgets/shared/PullToRefreshImage.dart';

class OrdenesPendientes extends StatefulWidget {
  static const String routeName = '/pendientes';

  @override
  _OrdenesPendientesState createState() => _OrdenesPendientesState();
}

class _OrdenesPendientesState extends State<OrdenesPendientes> {
  OTPendientesRepository _repoPendientes = OTPendientesRepository();
  PlantasRepository _repoPlanta = PlantasRepository();
  PendientesModel listaPendientesAux;
  PendientesModel listaPendientes;
  BusquedaProvider busqueda;
  BusquedaModel getBusqueda;
  PlantaProvider planta;
  PlantaModel plantaActual;

  bool _isLoading = false;
  var url;
  int cantRegistros = 0;

  Future<void> getData() async {
    plantaActual = await _repoPlanta.getPlantaSelect(); 
    listaPendientesAux = await _repoPendientes.fetchAllOTPendientes(plantaActual.servidor + '/pendientes');
    setState(() {
      _isLoading = false; 
    });
  }

  void initState() {
    super.initState();
    _isLoading = true;
    getData();
  }

  @override
  Widget build(BuildContext context)  {      
    busqueda = Provider.of<BusquedaProvider>(context);
    getBusqueda = busqueda.getBusqueda;
    planta = Provider.of<PlantaProvider>(context);


    if(plantaActual?.id != null && planta.getPlanta.id != null && plantaActual.id != planta.getPlanta.id) {
      plantaActual = planta.getPlanta;
    }

    if(getBusqueda.busqueda != null && getBusqueda.busqueda != '' && listaPendientesAux != null) {
      listaPendientes = PendientesModel(
        totalRegistros: listaPendientesAux.totalRegistros,
        data: listaPendientesAux.data.where((ot) => ot.id.toLowerCase().contains(getBusqueda.busqueda) || ot.cliente.toLowerCase().contains(getBusqueda.busqueda) || ot.trabajo.toLowerCase().contains(getBusqueda.busqueda)).toList()
      );
    } else {
      listaPendientes = listaPendientesAux;
    }

    cantRegistros = listaPendientes?.data?.length;

    return _isLoading ? Center(child: CircularProgressIndicator())
    : RefreshIndicator(
        onRefresh: getData,
        child: cantRegistros > 0
        ? ListView.builder(
          itemCount: cantRegistros,
          itemBuilder: (BuildContext context, int index) {
            var ot = listaPendientes.data[index];
              return GestureDetector(
                onTap: () { Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalleOT(id: ot.id, subID: ot.subId, cliente: ot.cliente, producto: ot.trabajo, cantPedida: ot.cantidadProducto, fechaOT: ot.fechaOT, fechaEntrega: ot.fechaEntrega)
                  ));
                },
                child: Card(      
                  elevation: 10,
                  margin: EdgeInsets.fromLTRB(4, 6, 4, 6),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('OT: ${ot.id}  SubOT: ${ot.subId}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        Text('${ot.cliente}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        Text(
                          '${ot.cantidadProducto} un - ${ot.trabajo}', 
                          textAlign: TextAlign.start, 
                          overflow: TextOverflow.ellipsis, 
                          style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                          maxLines: 2),
                        Row(
                          children: <Widget>[
                            Text('Fecha OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
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
                      ],
                    )
                  )
                )
              );
            // }
          }
        )
      : ListView(        
          children: <Widget>[ 
            Center(
              child: PullToRefreshImage(texto: 'ordenes')
            )
          ]
        )
      
    );
  }      
}