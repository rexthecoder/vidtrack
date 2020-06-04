import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Country _selected;
  String userd;
  Future<void> _launched;
  String userCountry;
  String _phone = '0549077429';

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String userUid = user.uid.toString();

    return userUid;
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
    Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  void printOrderMessage() async {
    var userId = await inputData();
    userd = userId;

    print('Your order is: $userId');
  }

  @override
  void initState() {
    printOrderMessage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: inputData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Container(
                    child: Column(children: <Widget>[
                      Container(
                        height: 330,
                        decoration: BoxDecoration(
                            color: Color(0xff131053),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "VIDTRACKER",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffBCC6E6),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 50.0,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: CountryPicker(
                                        dense: false,

                                        showFlag:
                                            true, //displays flag, true by default
                                        showDialingCode:
                                            true, //displays dialing code, false by default
                                        showName:
                                            false, //displays country name, true by default
                                        showCurrency:
                                            false, //eg. 'British pound'
                                        showCurrencyISO: false, //eg. 'GBP'
                                        onChanged: (Country country) {
                                          setState(() {
                                            _selected = country;
                                          });
                                        },
                                        selectedCountry: _selected,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Are you feeling sick?",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffE1E6F7),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Container(
                                  child: Text(
                                      "if you feel sick with any of Covid-19 symptoms please call or SMS us immediately for help.",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xffE1E6F7),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color(0xfffa3c24),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _launched =
                                                  _makePhoneCall('tel:$_phone');
                                            });
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.call),
                                                color: Colors.white,
                                                onPressed: () {
                                                  //  _launched = _makePhoneCall('tel:$_phone');
                                                },
                                              ),
                                              Text(
                                                "Call Now",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Container(
                                        width: 150,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color(0xff3c44c8),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _launched = _launchInWebViewOrVC(
                                                  "https://app.engati.com/static/standalone/bot.html?bot_key=919f1e2eea344ab5");
                                            });
                                      
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.message),
                                                color: Colors.white,
                                                onPressed: () {},
                                              ),
                                              Text(
                                                "Chat Us",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Prevention",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Lottie.asset(
                                    "assets/01.json",
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Clean your hands often",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Lottie.asset(
                                    "assets/02.json",
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Wear a facemask",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Lottie.asset(
                                    "assets/05.json",
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Avoid close contact",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xffB7A8C4),
                                Color(0xff3C44C8)
                              ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 100,
                                width: 100,
                                child: Lottie.asset(
                                  "assets/06.json",
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 200,
                                    child: Text("Do your own test!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    width: 220,
                                    child: Text(
                                      "Follow the instructions to do your own test",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      FutureBuilder<void>(future: _launched, builder: _launchStatus), ]),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
