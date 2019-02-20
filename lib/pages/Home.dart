import 'package:flutter/material.dart';
import 'package:sispromovil/pages/OrdenesPendientes.dart';
import 'package:sispromovil/pages/OrdenesPendientesPlanificadas.dart';
import 'package:sispromovil/pages/OrdenesEnCurso.dart';
import 'package:sispromovil/pages/OrdenesFinalizadas.dart';

 class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
 } // fin Home class

class _HomeState extends State<Home>  {
  int _selectedIndex = 0;
  // TabController controllerSolapas;

  @override
  void initState() {
    super.initState();
    // controllerSolapas =TabController(length: 4, vsync: this);
  }

  ListTile _getItem(Icon icon, String description, String route) {
    return ListTile(
      leading: icon,
      title: Text(description),
      onTap: () {
        setState(() {
          Navigator.of(context).pushNamed(route);
        });
      },
    );
  }

  List<Widget> _pantallas = <Widget> [
    OrdenesPendientes(),
    OrdenesPendientesPlanificadas(),
    OrdenesEnCurso(),
    OrdenesFinalizadas()
  ];

  void _seleccionarSolapa (int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Sispro Mobil'
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            _getItem(Icon(Icons.settings), 'Configuracion', '/configuracion')
          ],
        )
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).backgroundColor,
            child: _pantallas[_selectedIndex]
          ),
      ),
      bottomNavigationBar: BottomNavigationBar(        
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
           _selectedIndex = index; 
          });
        },        
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.assignment), title: Text('Pendientes', style:TextStyle(fontSize: 11))),
          BottomNavigationBarItem(icon: Icon(Icons.clear_all), title: Text('Programadas', style:TextStyle(fontSize: 11))),
          BottomNavigationBarItem(icon: Icon(Icons.important_devices), title: Text('En Curso', style:TextStyle(fontSize: 11))),
          BottomNavigationBarItem(icon: Icon(Icons.done_all), title: Text('Finalizadas', style:TextStyle(fontSize: 11))),
        ],
      ),
    );
  }
} // fin _HomeState class



  


 
