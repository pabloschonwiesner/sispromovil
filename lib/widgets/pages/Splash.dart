import 'package:flutter/material.dart';
import 'package:sispromovil/widgets/pages/Home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
 }
class _SplashState extends State<Splash> {

  @override
  void initState() { 
    super.initState();
    Future.delayed(Duration(milliseconds: 4500), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Theme.of(context).primaryColor,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Image.asset(
              
              'assets/imagenes/logoSisproMobile.png',
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
            )
          ),
          Text('SisPro Mobile', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold))
        ],
      )
    )
  );  
  }
}