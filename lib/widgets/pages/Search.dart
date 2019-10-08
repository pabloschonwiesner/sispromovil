import 'package:flutter/material.dart';
import 'package:sispromovil/models/BusquedaModel.dart';
import 'package:sispromovil/blocs/ordenesPendientes/BlocOTPendientes.dart';
import 'package:sispromovil/blocs/ordenesPendientesPlanificadas/BlocOTPendientesPlanificadas.dart';
import 'package:sispromovil/blocs/ordenesEnCurso/BlocOTEnCurso.dart';
import 'package:sispromovil/blocs/ordenesFinalizadas/BlocOTFinalizadas.dart';
import 'package:sispromovil/blocs/plantas/BlocPlanta.dart';


import 'package:sispromovil/providers/BusquedaProvider.dart';
import 'package:sispromovil/repositories/busquedas/Busquedas_Repository.dart';


class Search extends SearchDelegate {  
  BuildContext contexto;
  BusquedaRepository _repoBusquedas = BusquedaRepository();
  BusquedaProvider bp;

  Search(this.contexto) {
    bp = Provider.of<BusquedaProvider>(contexto);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text('${this.query}')
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: <Widget>[
        bp.getBusqueda.id != null && bp.getBusqueda.id > 0
        ?  FutureBuilder(
            future: _repoBusquedas.getBusqueda(bp.getBusqueda.id),
            builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.data != '') {
                return Dismissible(
                  key: Key('filtro'),
                  onDismissed: (direction) {
                    bp.setBusqueda(BusquedaModel(id: 0, busqueda: ''));
                    close(context, '');
                  },
                  child: Ink(
                    color: Colors.lightBlue[100],
                    child: ListTile(  
                      title: RichText(
                        maxLines: 2,
                        text: TextSpan(
                          text: 'Filtro aplicado: \n',                        
                          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 11, color: Colors.black),
                          children: [
                            TextSpan(
                              text: snapshot.data.busqueda,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)
                            )
                          ]
                        ),                        
                      ),
                      onTap: () {
                        query = snapshot.data;
                        close(context, this.query);
                      }
                    ),
                  ),
                );
              } else {
                return Container(width: 0, height: 0,);
              }
            },
          )
        : Container(width: 0, height: 0),
        FutureBuilder(
          future: _repoBusquedas.getBusquedas(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {          
              return Expanded(
                flex: 1,
                child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  BusquedaModel busqueda = snapshot.data[index];
                  return Dismissible(
                    key: Key(busqueda.id.toString()),
                    onDismissed: (direction) {
                      _repoBusquedas.deleteBusqueda(busqueda.id);
                    },
                    child: ListTile(
                      leading: Icon(Icons.history),
                      title: Text(busqueda.busqueda),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_upward),
                        onPressed: () {
                          query = busqueda.busqueda;
                        },
                      ),
                      onTap: () {
                        query = busqueda.busqueda;
                        // cambiarFiltros();
                        BusquedaModel obj = BusquedaModel(id: busqueda.id, busqueda: busqueda.busqueda);
                        bp.setBusqueda(obj);
                        close(context, this.query);
                      },
                    )
                  );
                },
              )
              );              
            } else {
              return Container(height: 0, width: 0,);
            }
          },
        ),
      ],
    );
  }
  
  @override
  void showResults(BuildContext context) async {
    int id = await _repoBusquedas.addBusqueda(this.query);
    BusquedaModel obj = BusquedaModel(id: id, busqueda: this.query);
    bp.setBusqueda(obj);
    this.query = '';
    close(context, null);
    super.showResults(context);
  }

}