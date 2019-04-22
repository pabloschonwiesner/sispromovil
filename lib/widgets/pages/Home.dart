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


 class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
 } // fin Home class

class _HomeState extends State<Home>  {
  int _solapaSeleccionada = 0;

  @override
  void initState() {
    super.initState();    
    // blocPlanta.llenarListaPlantas();
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search()
                ));
            },
          ),
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    print('boton notificaciones presionado');
                  },
                )
              ),            
              Positioned(
                right: 7,
                top: 10,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(18)
                  ),
                  child: Center(
                    child: Text(
                      '6', 
                      style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold), 
                      textAlign: TextAlign.center,
                      ),
                  )
                ),
              )
            ]
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
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
              height: 200,
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
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) => Home()
                            // ));
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
    );
  }
} // fin _HomeState class



  


 
