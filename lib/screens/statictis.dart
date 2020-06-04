import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vidtrack/screens/barchart.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class Statictis extends StatefulWidget {
  @override
  _StatictisState createState() => _StatictisState();
}

class _StatictisState extends State<Statictis> {
  String userUid;
  String userCountry;
  String dAuth;
  String name;

  int totalCases = 0;
  int deaths = 0;
  int recovered = 0;
  int ghCases = 0;
  int ghdeaths = 0;
  int ghrecovered = 0;
  int active = 0;
  int numberOfCountries = 0;
  List countries = [];
  bool isActive = true;
  int event = 1;
  int ghactive = 0;

  Future<String> inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String userUid = user.uid.toString();

    return userUid;
  }

  void printOrderMessage() async {
    var userId = await inputData();
    print('Your order is: $userId');
  }

  @override
  void initState() {
    getTotalCasesForCorona();

    getCasesForCorona();
    printOrderMessage();
    Timer.periodic(
      Duration(hours: 1),
      (Timer t) => getTotalCasesForCorona(),
    );
    Timer.periodic(
      Duration(hours: 1),
      (Timer t) => getCasesForCorona(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: inputData(),
            builder: (context, id) {
              if (id.hasData) {
                dAuth = id.data;
                print(dAuth);
                return StreamBuilder(
                    stream: Firestore.instance
                        .collection('users')
                        .document(dAuth)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      userCountry =
                          snapshot.data["CountryName"].toString().toLowerCase();
                      // getTotalCasesForCorona();
                      // Timer.periodic(
                      //   Duration(hours: 1),
                      //   (Timer t) => getTotalCasesForCorona(),
                      // );
                      return SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: [
                                  Container(
                                    height: 520,
                                    color: Color(0xff131053),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(Icons.dashboard),
                                              color: Color(0xffE1E6F7),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.notifications),
                                              color: Color(0xffE1E6F7),
                                              onPressed: () {},
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30),
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Statistics",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffE1E6F7),
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          height: 50,
                                          width: 300,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withAlpha(150),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isActive = true;
                                                  });
                                                },
                                                child: isActive == true
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4.0),
                                                        child: Container(
                                                          height: 40,
                                                          width: 130,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          30))),
                                                          child: Text(
                                                              "My Country",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4.0),
                                                        child: Container(
                                                          height: 40,
                                                          width: 130,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(

                                                                  // color: Colors.white,

                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              30))),
                                                          child: Text(
                                                              "My Country",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                      ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isActive = false;
                                                  });
                                                },
                                                child: isActive == false
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 4.0),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: 40,
                                                          width: 130,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          30))),
                                                          child: Text("Global",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 4.0),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: 40,
                                                          width: 130,
                                                          decoration:
                                                              BoxDecoration(

                                                                  // color: Colors.white,

                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              30))),
                                                          child: Text("Global",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                        ),
                                                      ),
                                              )
                                            ],
                                          ),
                                        ),
                                       
                                      
                                        SizedBox(
                                          height: 60,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                height: 110,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 10),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              "Affected",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ))),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 50.0,
                                                              left: 10),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: isActive == true ? Text(
                                                              "$ghCases",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white)):  Text(
                                                              "$totalCases",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white)))  ,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 110,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                    color: Color(0xfffa3c24),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 10),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text("Death",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ))),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 50.0,
                                                              left: 10),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: isActive == true ? Text("$ghdeaths",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white)): Text(
                                                              "$deaths",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white))),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                height: 110,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 10),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              "Recovered",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ))),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 50.0,
                                                              left: 10),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: isActive == true? Text(
                                                              "$ghrecovered",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white)):  Text(
                                                              "$recovered",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white))),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 110,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                    color: Color(0xfffa3c24),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 10),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text("Active",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ))),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 50.0,
                                                              left: 10),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: isActive == true ? Text("$ghactive",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white)):Text("$active",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white))),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 500.0),
                                    child: Container(
                                      height: 200,
                                      child: sample8(context),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            }));
  }

  Future getTotalCasesForCorona() async {
    String url = "https://corona.lmao.ninja/v2/all";
    http.Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        totalCases = data['cases'];
        deaths = data['deaths'];
        recovered = data['recovered'];
        active = data['active'];
        print(userCountry);
      });

      print(data);
    } else {
      print(response.statusCode);
    }
  }

  Future getCasesForCorona() async {
    String url = "https://corona.lmao.ninja/v2/countries/ghana";
    http.Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        ghCases = data['cases'];
        ghdeaths = data['deaths'];
        ghrecovered = data['recovered'];
        ghactive = data['active'];
        print("country $userCountry");
      });
      print(data);
    } else {
      print(response.statusCode);
    }
  }
}
