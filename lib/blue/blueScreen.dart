import 'package:app_settings/app_settings.dart';
import 'package:vidtrack/providers/bluetooth.dart';
import 'package:vidtrack/blue/myapp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class BlueHome extends StatefulWidget {
  @override
  _BlueHomeState createState() => _BlueHomeState();
}

class _BlueHomeState extends State<BlueHome> {

  @override
  Widget build(BuildContext context) {
    final blue = Provider.of<BlueToothProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Corona Out"),
          centerTitle: true,
          elevation: 0.5,
        ),
        backgroundColor: Colors.white,
        body: blue.isOn ? Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/plp.png",
                  width: 100,
                ),


              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("People Near You!",style: TextStyle( fontSize: 24, fontWeight: FontWeight.w300,)),
            ),

            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(blue.data, style:TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.grey,)),
            ),

            SizedBox(height: 5),
            IconButton(icon: Icon(Icons.add_location), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Blue()));
              // changeScreen(context, Blue());
            }),

            SizedBox(
              height: 10,
            ),
          ],
        ) : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/off.png",
                  width: 160,
                ),


              ],
            ),

            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Your Bluetooth is turned off, please turn on the bluetooth and click on 'refresh'", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),),
            ),

            FlatButton.icon(onPressed: (){
              blue.turnOn();
            }, icon: Icon(Icons.refresh), label: Text("refresh")),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}