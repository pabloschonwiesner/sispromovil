import 'package:flutter/material.dart';
import 'package:sispromovil/widgets/pages/OrdenesPendientes.dart';
import 'package:sispromovil/widgets/pages/OrdenesPendientesPlanificadas.dart';
import 'package:sispromovil/widgets/pages/OrdenesEnCurso.dart';
import 'package:sispromovil/widgets/pages/OrdenesFinalizadas.dart';
import 'package:sispromovil/widgets/pages/Search.dart';
import 'package:sispromovil/models/PlantaModel.dart';
import 'package:sispromovil/widgets/pages/CrearPlanta.dart';
import 'package:sispromovil/widgets/pages/EditarPlanta.dart';
import 'package:sispromovil/blocs/plantas/BlocPlantaProvider.dart';
import 'package:sispromovil/blocs/plantas/BlocPlanta.dart';
import 'package:sispromovil/widgets/pages/Notificaciones.dart';
import 'package:sispromovil/blocs/notificaciones/BlocNotificaciones.dart';


 class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
 } // fin Home class

class _HomeState extends State<Home>  {
  int _solapaSeleccionada = 0;

  @override
  void initState() {
    super.initState();    
    blocNotificaciones.initialData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _pantallas = <Widget> [
    OrdenesPendientes(),
    OrdenesPendientesPlanificadas(),
    OrdenesEnCurso(),
    OrdenesFinalizadas()
  ];

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Está saliendo de la aplicación'),
        content: new Text('¿Está seguro?'),
        actions: <Widget>[
          new IconButton(

            icon: Icon(Icons.check),
            color: Colors.green,
            onPressed: () => Navigator.of(context).pop(true),
          ),
          new IconButton(
            icon: Icon(Icons.clear),
            color: Colors.red,
            onPressed: () => Navigator.of(context).pop(false),            
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
            StreamBuilder(
              stream: blocPlanta.filtro,
              builder: (context, snapshot) {
                if(snapshot.hasData && snapshot.data != '') {
                  return IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.greenAccent, size: 30,),
                    onPressed: () {
                      showSearch(context: context, delegate: Search());
                    },
                  );                
                } else {
                  return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(context: context, delegate: Search());
                    },
                  );
                }
              },
            ),
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Notificaciones()
                      ));
                    }
                  )
                ),            
                Positioned(
                  right: 7,
                  top: 10,
                  child: StreamBuilder(
                    stream: blocNotificaciones.cantidadNotificaciones,
                    builder: (context, snapshot) {
                      // if(snapshot.connectionState == ConnectionState.done) {
                      //   print('Done');
                      // }
                      // if(snapshot.connectionState == ConnectionState.waiting) {
                      //   print('Waiting');
                      // }
                      // if(snapshot.connectionState == ConnectionState.active) {
                      //   print('Active');
                      // }

                      if(snapshot.hasData && snapshot.data > 0) {
                          return Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(18)
                            ),
                            child: Center(
                              child: Text(
                                snapshot.data.toString(),
                                style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold), 
                                textAlign: TextAlign.center,
                              ),
                            )
                          );
                        } else {
                          return Container(width: 0, height: 0,);
                        }
                      
                    },
                  ),
                ),
                Positioned(
                  left: 4,
                  top: 4,
                  child: Container(
                    width: 18,
                    height: 18,
                    child: Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: IconButton(
                        icon: Icon(Icons.notifications, color: Colors.transparent),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Notificaciones()
                          ));
                        }
                      )
                    ),  
                  ),
                )
              ]
            )
          ],
        ),
        drawer: Drawer(          
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Image.asset(
                          'assets/imagenes/logoUpsoftware.png',
                        ),
                    ),  
                    Text('Version 2.0.0', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic), textAlign: TextAlign.center,)
                  ],
                )              
              ),
              ListTile(
                title: Text('Plantas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                trailing: IconButton(
                  icon: Icon(Icons.add_circle),
                  color: Colors.blueAccent,                
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CrearPlanta()
                    ));
                  },
                ),
              ),
              Divider(height: 10,),
              Container(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                  stream: blocPlanta.listaPlantas,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {  
                    if(snapshot.hasData) {
                      return ListView.builder(                                     
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {                      
                          PlantaModel param = snapshot.data[index];
                          return ListTile(
                            leading: param.seleccionada == 1 
                              ? Icon(Icons.radio_button_checked, color: Colors.blueAccent, )
                              : Icon(Icons.radio_button_unchecked, color: Colors.grey),
                            title: Text('${param.planta}'),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {Navigator.push(context, MaterialPageRoute(
                                builder: (context) => EditarPlanta(param)
                              ));
                              }
                            ),
                            onTap: () {
                              blocPlanta.seleccionarPlanta(param.id);
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
              )
              
            ],
          )
        ),
        body: Center(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: _pantallas[_solapaSeleccionada]
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(        
          currentIndex: _solapaSeleccionada,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
            _solapaSeleccionada = index; 
            });
          },        
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.assignment), title: Text('Pendientes', style:TextStyle(fontSize: 11))),
            BottomNavigationBarItem(icon: Icon(Icons.clear_all), title: Text('Programadas', style:TextStyle(fontSize: 11))),
            BottomNavigationBarItem(icon: Icon(Icons.directions_run), title: Text('En Curso', style:TextStyle(fontSize: 11))),
            BottomNavigationBarItem(icon: Icon(Icons.done_all), title: Text('Finalizadas', style:TextStyle(fontSize: 11))),
          ],
        ),
      )
    );
  }
} // fin _HomeState class



  


 
