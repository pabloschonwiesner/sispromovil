import 'package:flutter/material.dart';
import 'package:sispromovil/models/BusquedaModel.dart';
import 'package:sispromovil/models/FinalizadasModel.dart';
import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sispromovil/providers/BusquedaProvider.dart';
import 'package:sispromovil/providers/PlantaProvider.dart';
import 'package:sispromovil/repositories/otFinalizadas/OT_Finalizadas_Repository.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository.dart';
import 'package:sispromovil/widgets/pages/DetalleOT.dart';
import 'package:intl/intl.dart';
import 'package:sispromovil/widgets/shared/PullToRefreshImage.dart';

class OrdenesFinalizadas extends StatefulWidget {
  static const String routeName = '/finalizadas';

  @override
  _OrdenesFinalizadas createState() => _OrdenesFinalizadas();
}

class _OrdenesFinalizadas extends State<OrdenesFinalizadas> {
  OTFinalizadasRepository _repoFinalizadas = OTFinalizadasRepository();
  PlantasRepository _repoPlanta = PlantasRepository();
  FinalizadasModel listaFinalizadasAux;
  FinalizadasModel listaFinalizadas;
  BusquedaProvider busqueda;
  BusquedaModel getBusqueda;
  PlantaProvider planta;
  PlantaModel plantaActual;

  bool _isLoading = false;
  var url;
  int cantRegistros = 0;


  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getData();
  }

  Future<void> getData() async {
    plantaActual = await _repoPlanta.getPlantaSelect();
    listaFinalizadasAux = await _repoFinalizadas.fetchAllOTFinalizadas('${plantaActual.servidor}/finalizadas');
    setState(() {
      _isLoading = false;
    });
  }

  Widget _listaOTSFinalizadas(FinalizadasModel itemsFinalizados) {
    double alto = MediaQuery.of(context).textScaleFactor * 100;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Flexible(
        child: ListView.builder(
          itemCount: itemsFinalizados.data.length,
          itemBuilder: (BuildContext context, int index) {
            var ot = itemsFinalizados.data[index];
              return GestureDetector(
                onTap: () { Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalleOT(id: ot.id, subID: ot.subId, cliente: ot.cliente, producto: ot.trabajo, cantPedida: ot.cantidadProducto, fechaOT: ot.fechaOT, fechaEntrega: ot.fechaEntrega)
                  ));
                },
                child: Card(
                  margin: EdgeInsets.fromLTRB(4,4,4,15),
                  elevation: 15,
                  child: Container(
                    height: alto,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 4, 4, 5),
                              child: Column(                      
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[                     
                                  Text('OT: ${ot.id}  SubOT: ${ot.subId}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                                  Text('${ot.cliente}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                  Text('${ot.cantidadProducto} un -${ot.trabajo}', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
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
                                  Row(
                                    children: <Widget>[
                                      Text('Inicio OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                      Text('${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(ot.inicioOt))}', style: TextStyle(fontSize: 12))
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('Fin OT: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                      Text('${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(ot.finOt))}', style: TextStyle(fontSize: 12))
                                    ],
                                  ),
                                  
                                ],
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              );
            // }
          })
        )      
      ]
    );
    
  }

  @override
  Widget build(BuildContext context) {
    busqueda = Provider.of<BusquedaProvider>(context);
    getBusqueda = busqueda.getBusqueda;
    planta = Provider.of<PlantaProvider>(context);

    if(plantaActual?.id != null && planta.getPlanta.id != null && plantaActual.id != planta.getPlanta.id) {
      plantaActual = planta.getPlanta;
    }
    
    if(getBusqueda.busqueda != null && getBusqueda.busqueda != '' && listaFinalizadasAux != null) {
      listaFinalizadas = FinalizadasModel(
        totalRegistros: listaFinalizadasAux.totalRegistros,
        data: listaFinalizadasAux.data.where((ot) => ot.id.toLowerCase().contains(getBusqueda.busqueda) || ot.cliente.toLowerCase().contains(getBusqueda.busqueda) || ot.trabajo.toLowerCase().contains(getBusqueda.busqueda)).toList()
      );
    } else {
      listaFinalizadas = listaFinalizadasAux;
    }

    cantRegistros = listaFinalizadas?.data?.length;

    return _isLoading ? Center(child: CircularProgressIndicator())
      : RefreshIndicator(
        onRefresh: getData,
        child: cantRegistros > 0
          ? _listaOTSFinalizadas(listaFinalizadas)
          : ListView(        
              children: <Widget>[ 
                Center(
                  child: PullToRefreshImage(texto: 'ordenes')
                )
              ]
            )
      );
  }


  @override
  void dispose() {
    super.dispose();
  }
}