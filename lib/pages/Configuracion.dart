import 'package:flutter/material.dart';

class Configuracion extends StatefulWidget {
  static const String routeName = '/configuracion';
  @override
  _Configuracion createState() => _Configuracion();
}

class _Configuracion extends State<Configuracion> {

  final bdServidorController = TextEditingController();
  final bdNombreController = TextEditingController();
  String inputValue = '';
  List<ItemsPanel> _itemsPanel = <ItemsPanel> [
    ItemsPanel(isExpanded: false, header: 'Base de datos', body: 'Este es el panel 1'),
    // ItemsPanel(isExpanded: false, header: 'Servidor Web', body: 'Este es el panel 2'),
    // ItemsPanel(isExpanded: false, header: 'Usuario', body: 'Este es el panel 3'),
  ];

  // final _configBD =
  //   Column(
  //     children: <Widget>[ 
  //       TextField(
  //         keyboardType: TextInputType.number,
  //         decoration: InputDecoration(labelText: 'IP Servidor BD'),
  //         controller: bdServidorController,
  //         onSubmitted: (String value) {
  //             inputValue += value;
  //         },
  //       ),
  //       TextField(

  //         keyboardType: TextInputType.text,
  //         decoration: InputDecoration(labelText: 'Nombre BD:'),
  //         controller: bdNombreController,
  //         onSubmitted: (String value) {
  //           setState(() {
  //             inputValue += value;
  //           });
  //         }
  //       ),
  //         TextField(
  //           keyboardType: TextInputType.text,
  //           decoration: InputDecoration(labelText: 'Usuario BD'),
  //         ),
  //         TextField(
  //           keyboardType: TextInputType.text,
  //           decoration: InputDecoration(labelText: 'Password BD'),
  //           obscureText: true,
  //         )
        
  //     ],          
  //   );    
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuracion'
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
            child: ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _itemsPanel[index].isExpanded = !_itemsPanel[index].isExpanded; 
                });
              },
              children: _itemsPanel.map((ItemsPanel item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Text(item.header);
                  },
                  isExpanded: item.isExpanded,
                  body:  Container(
                    child: Text(item.body),
                  ),

                );
              }).toList(),
            ),
          )
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: ExpansionTile(
          //     initiallyExpanded: false,
          //     title: Text('Base de datos'),
          //     children: <Widget>[ 
          //         TextField(
          //           keyboardType: TextInputType.number,
          //           decoration: InputDecoration(labelText: 'IP Servidor BD'),
          //           controller: bdServidorController,
          //           onSubmitted: (String value) {
          //               inputValue += value;
          //           },
          //         ),
          //         TextField(

          //           keyboardType: TextInputType.text,
          //           decoration: InputDecoration(labelText: 'Nombre BD:'),
          //           controller: bdNombreController,
          //           onSubmitted: (String value) {
          //             setState(() {
          //               inputValue += value;
          //             });
          //           },
          //           TextField(
          //             keyboardType: TextInputType.text,
          //             decoration: InputDecoration(labelText: 'Usuario BD'),
          //           ),
          //           TextField(
          //             keyboardType: TextInputType.text,
          //             decoration: InputDecoration(labelText: 'Password BD'),
          //             obscureText: true,
          //           )
          //         )
          //       ],                                   
              
          //   )
          // )
        ],
      ),
    );
  }
} // final class _Configuracion


class ItemsPanel {
  bool isExpanded;
  final String header;
  final String body;
  ItemsPanel({this.isExpanded, this.header, this.body});
}