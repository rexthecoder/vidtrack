import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:flutter/material.dart';
import 'package:vidtrack/screens/statictis.dart';
import 'package:vidtrack/dashboard/homepage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> tab = [
    Homepage(),
    Statictis()
   
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: tab[currentIndex],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.equalizer),
            title: Text('Statistics'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text(
              'Messages test for mes teset test test ',
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
// Container(
//         child: Column(
//           children: <Widget>[
//             Container(
//               child: Column(children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(Icons.dashboard),
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.notifications),
//                       onPressed: () {},
//                     )
//                   ],
//                 ),
//                 Row(
//                   children: <Widget>[
//                     Text("VIDTRACKER"),
//                     Container(
//                       width: 50.0,
//                       height: 50.0,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       child: CountryPicker(
//                         dense: false,

//                         showFlag: true, //displays flag, true by default
//                         showDialingCode:
//                             false, //displays dialing code, false by default
//                         showName: true, //displays country name, true by default
//                         showCurrency: false, //eg. 'British pound'
//                         showCurrencyISO: false, //eg. 'GBP'
//                         onChanged: (Country country) {
//                           setState(() {
//                             _selected = country;
//                           });
//                         },
//                         selectedCountry: _selected,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   child: Text("Are you feeling sick?"),
//                 ),
//                 Container(
//                   child: Text(
//                       "if you feel like sick with any of Covid-19 symptoms please call or SMS us immediately for help"),
//                 ),
//                 Row(
//                   children: <Widget>[
//                     Container(
//                       child: ListTile(
//                         leading: Icon(Icons.call),
//                         title: Text("Call Now"),
//                       ),
//                     ),
//                      Container(
//                       child: ListTile(
//                         leading: Icon(Icons.message),
//                         title: Text("Send SMS"),
//                       ),
//                     ),
//                   ],
//                 )
//               ]),
//             )
//           ],
//        ), ),
