import 'package:flutter/material.dart';
import 'package:sispromovil/blocs/plantas/BlocPlantaProvider.dart';

class Search extends StatefulWidget {
  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> with TickerProviderStateMixin {
  TextEditingController _searchController =TextEditingController();
  String inputValue = '';
  BlocPlanta _blocPlanta;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _blocPlanta = BlocPlantaProvider.of(context);
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          Flexible(
          child:
            Container(
              height: 200,
              child: Center(
                child: Text('prueba')
                // StreamBuilder(
                //   initialData: '',
                //   stream: ,
                //   builder: (context, snapshot) {
                //     return TextField(     
                //       keyboardType: TextInputType.text,  
                //       textInputAction: TextInputAction.send,   
                //       autocorrect: false,  
                //       decoration: InputDecoration(
                //         hintText: 'OT, Cliente o Producto',
                //         hintStyle: TextStyle(color: Colors.grey[500], fontStyle: FontStyle.italic),
                //         contentPadding: EdgeInsets.only(left: 60),
                //         border: InputBorder.none,
                //         errorText: snapshot.error,
                //       ),
                //       style: TextStyle( backgroundColor: Colors.white),                
                //       controller: _searchController,
                //       autofocus: true,
                //       onChanged: bloc.changeSearchController,
                //       // onSubmitted: (String texto) {
                //       //   setState(() {
                //       //     inputValue = texto;
                //       //   });
                //       //   print(inputValue);
                //       // },
                //     );
                //   }
                // )
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.cancel),
            color: Theme.of(context).primaryColor,
            onPressed: () => _searchController.text = '',
          )

        ],
      ),
      // body: Container(
      //   child: StreamBuilder(
      //     stream: bloc.email,
      //     builder: (context, snapshot) {
      //       Text()
      //     },
      //   ),
      // ),
    );
  }
}