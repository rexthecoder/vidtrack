import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BluetoothAddress extends StatefulWidget {
  @override
  _BluetoothAddressState createState() => _BluetoothAddressState();
}

class _BluetoothAddressState extends State<BluetoothAddress> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  Colors.white,
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/bluetooth.png",
                  width: 160,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("Almost there!", style:TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            RichText(
                text: TextSpan(children: [
                  TextSpan(text: "Just have to add your"),
                  TextSpan(text: " Bluetooth", style: TextStyle(color: Colors.blue.shade900)),
                  TextSpan(text: " address"),
                ], style: TextStyle(color: Colors.black))),
            SizedBox(height: 10),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("We're sorry for the extra work ;) \n Find the address at \n SETTINGS > ABOUT PHONE > STATUS", textAlign: TextAlign.center, style: TextStyle(color:Colors.grey),),
            ),
            Padding(
              padding: const EdgeInsets.only(left:12, right: 12, bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color:Colors.black, width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(2, 1),
                          blurRadius: 2
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: TextField(
//                    keyboardType: TextInputType.phone,
                    // controller: auth.address,
                    decoration: InputDecoration(
                        icon: Icon(Icons.bluetooth_audio, color:Colors.grey),
                        border: InputBorder.none,
                        hintText: "21:AE:7A:B3:BB:05",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Sen",
                            fontSize: 18
                        )
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),
            // CustomButton(msg: "Send Address", onTap: (){
            //   auth.setBluetoothAddress(id: auth.user.uid, bluetoothAddress: auth.address.text.trim());
            //   changeScreenRebplacement(context, Home());
            // })
          ]),
        ),
      ),
    );
  }
}
