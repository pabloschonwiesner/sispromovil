import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sispromovil/models/BusquedaModel.dart';
import 'package:sispromovil/models/PendientesModel.dart';
import 'package:sispromovil/providers/BusquedaProvider.dart';
import 'package:sispromovil/widgets/pages/DetalleOT.dart';
import 'package:sispromovil/repositories/plantas/Plantas_Repository.dart';
import 'package:sispromovil/repositories/otPendientes/OT_Pendientes_Repository.dart';

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

  bool _isLoading;
  var url;

  Future<void> getData() async {
    print('getData');
    _isLoading = true;    
    url = await _repoPlanta.getPlantaSelect(); 
    listaPendientesAux = await _repoPendientes.fetchAllOTPendientes(url.servidor + '/pendientes');    
    setState(() => _isLoading = false);
  }

  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context)  {      
    print('build');
    busqueda = Provider.of<BusquedaProvider>(context);
    getBusqueda = busqueda.getBusqueda;
    if(getBusqueda.busqueda != null && getBusqueda.busqueda != '') {
      listaPendientes = PendientesModel(
        totalRegistros: listaPendientesAux.totalRegistros,
        data: listaPendientesAux.data.where((ot) => ot.id.toLowerCase().contains(getBusqueda.busqueda) || ot.cliente.toLowerCase().contains(getBusqueda.busqueda) || ot.trabajo.toLowerCase().contains(getBusqueda.busqueda)).toList()
      );
    } else {
      listaPendientes = listaPendientesAux;
    }

    return _isLoading ? Center(child: CircularProgressIndicator())
    : RefreshIndicator(
        onRefresh: getData,
        child: ListView.builder(
        itemCount: listaPendientes.data.length,
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
                      Text('${getBusqueda?.busqueda}'),
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
      ),
    );
  }      
}