import 'package:flutter/material.dart';
import 'package:sispromovil/blocs/busqueda/BlocBusqueda.dart';
import 'package:sispromovil/models/BusquedaModel.dart';

class Search extends SearchDelegate {
  

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
      child: Text(this.query)
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder(
          stream: blocBusquedas.filtro,
          builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.data != '') {
              return Dismissible(
                key: Key('filtro'),
                onDismissed: (direction) {
                  blocBusquedas.changeFiltro('');
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
                            text: snapshot.data,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)
                          )
                        ]
                      ),
                      
                    ),
                    onTap: () {
                      query = snapshot.data;
                      blocBusquedas.changeFiltro(query);
                      close(context, this.query);
                    }
                  ),
                ),
              );
            } else {
              return Container(width: 0, height: 0,);
            }
          },
        ),
        StreamBuilder(
          stream: blocBusquedas.listaBusquedas,
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
                      blocBusquedas.borrarBusqueda(busqueda.id);
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
                        blocBusquedas.changeFiltro(query);
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
          }
        )
      ],
    );
  }
  
  @override
  void showResults(BuildContext context) {
    blocBusquedas.changeFiltro(query);
    blocBusquedas.agregarBusqueda(query);
    close(context, null);
    super.showResults(context);
  }
  

}