import 'package:flutter/material.dart';
import 'package:sispromovil/models/BusquedaModel.dart';
import 'package:sispromovil/models/EnCursoModel.dart';
import 'package:intl/intl.dart';
import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sispromovil/providers/BusquedaProvider.dart';
import 'package:sispromovil/providers/PlantaProvider.dart';
import 'package:sispromovil/repositories/otEnCurso/OT_EnCurso_Repository.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository.dart';
import 'package:sispromovil/widgets/pages/DetalleOT.dart';
import 'package:sispromovil/widgets/shared/PullToRefreshImage.dart';

class OrdenesEnCurso extends StatefulWidget {
  static const String routeName = '/enCurso';
  @override
  _OrdenesEnCurso createState() => _OrdenesEnCurso();
}

class _OrdenesEnCurso extends State<OrdenesEnCurso> {
  PlantasRepository _repoPlanta = PlantasRepository();
  OTEnCursoRepository _repoEnCurso = OTEnCursoRepository();
  EnCursoModel _listaEnCurso; 
  EnCursoModel _listaEnCursoAux; 
  BusquedaProvider busqueda;
  BusquedaModel getBusqueda;
  PlantaProvider planta;
  PlantaModel plantaActual;
  bool _isLoading = false;
  int cantRegistros = 0;


  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getData();
  }

  Future<void> getData() async {
    PlantaModel _planta = await _repoPlanta.getPlantaSelect();
    _listaEnCursoAux = await _repoEnCurso.fetchAllOTEnCurso('${_planta.servidor}/enProceso');
    setState(() {
      _isLoading = false; 
    });
  }

  String _hsSexagesimales(double hs) {
    var minutos = ((hs - hs.floor()) * 60).round();
    String strMinutos = '';
    minutos < 10
        ? strMinutos = '0' + minutos.toString()
        : strMinutos = minutos.toString();
    return hs.floor().toString() + ':' + strMinutos;
  }

  Widget _listaRecursos(EnCursoModel itemsEnCurso) {
    double anchoPantalla = MediaQuery.of(context).size.width;
    double alto = MediaQuery.of(context).textScaleFactor > 1
        ? 130 * MediaQuery.of(context).textScaleFactor * 1.15
        : 130;
    return Center(
        child: ListView.builder(
            itemCount: itemsEnCurso.data.length,
            itemBuilder: (BuildContext context, int index) {
              var recurso = itemsEnCurso.data[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetalleOT(
                              id: recurso.id,
                              subID: recurso.subId,
                              cliente: recurso.descripcionCliente,
                              producto: recurso.trabajo,
                              cantPedida: recurso.cantidadProducto,
                              fechaOT: recurso.fechaOT,
                              fechaEntrega: recurso.fechaEntrega)));
                },
                child: Card(
                    margin: EdgeInsets.fromLTRB(4, 4, 4, 15),
                    elevation: 10,
                    child: Container(
                      height: alto,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: Color.fromRGBO(recurso.red,
                                              recurso.green, recurso.blue, 1.0),
                                          width: 10)),
                                ),
                                height: alto
                            ),
                          ),
                          Expanded(
                            flex: 40,
                              child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 4, 4, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1),
                                  child: Text('${recurso.descRecurso}',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)),
                                ),
                                Text(
                                  'OT: ${recurso.id}  SubOT: ${recurso.subId}',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('${recurso.descripcionCliente}',
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  '${recurso.cantidadProducto} un - ${recurso.trabajo}',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,                                  
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontStyle: FontStyle.italic),
                                  maxLines: 2,
                                ),
                                Wrap(
                                  children: <Widget>[
                                    Text('Fecha OT: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                    Text(
                                        '${recurso.fechaOT.isEmpty ? '' : DateFormat('dd/MM/yyyy').format(DateTime.parse(recurso.fechaOT))}',
                                        style: TextStyle(fontSize: 12)),
                                    Text('   Fecha Ent: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                    Text(
                                      '${recurso.fechaEntrega.isEmpty ? '' : DateFormat('dd/MM/yyyy').format(DateTime.parse(recurso.fechaEntrega))}',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),

                                Wrap(
                                  children: <Widget>[
                                    Text('Cant Prog: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                    Text('${recurso.cantBuenosProg.floor()}',
                                        style: TextStyle(fontSize: 12)),
                                    Text('    Hs Prog: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                    Text(
                                        '${recurso.cantidadHorasProgTotales > 0 ? _hsSexagesimales(recurso.cantidadHorasProgTotales) : _hsSexagesimales(recurso.horasBarra)}',
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                                Wrap(
                                  children: <Widget>[
                                    Text('Cant Producida: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                    Text('${recurso.cantidadBuenos.round()}',
                                        style: TextStyle(fontSize: 12))
                                  ],
                                )
                              ],
                            ),
                          )),
                          Expanded(
                            flex: 8,
                            child: Container(
                              width: anchoPantalla * 0.14,
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              color: Colors.grey[200],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${recurso.porcAvance.floor()} %',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    busqueda = Provider.of<BusquedaProvider>(context);
    getBusqueda = busqueda.getBusqueda;
    planta = Provider.of<PlantaProvider>(context);

    if(plantaActual?.id != null && planta.getPlanta.id != null && plantaActual.id != planta.getPlanta.id) {
      plantaActual = planta.getPlanta;
      getData();
    }

    if(getBusqueda.busqueda != null && getBusqueda.busqueda != '' && _listaEnCursoAux != null) {
      _listaEnCurso = EnCursoModel(
        data: _listaEnCursoAux.data.where((ot) => ot.id.toLowerCase().contains(getBusqueda.busqueda) || ot.descripcionCliente.toLowerCase().contains(getBusqueda.busqueda) || ot.trabajo.toLowerCase().contains(getBusqueda.busqueda)).toList()
      );
    } else {
      _listaEnCurso = _listaEnCursoAux;
    }

    cantRegistros = _listaEnCurso?.data?.length;

    return _isLoading ? Center(child: CircularProgressIndicator(),)
      : RefreshIndicator(
        onRefresh: getData,
        child: cantRegistros > 0
          ? _listaRecursos(_listaEnCurso)
          : ListView(        
              children: <Widget>[ 
                Center(
                  child: PullToRefreshImage(texto: 'ordenes',)
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
