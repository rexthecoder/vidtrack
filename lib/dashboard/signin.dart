import 'package:vidtrack/dashboard/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:vidtrack/providers/authservice.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Country _selected;
  String userPhone;
  TextEditingController number = TextEditingController();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0C12D8),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Container(
                  child: Lottie.asset('assets/meditation.json'),
                ),
              ),
              Container(
                child: Text(
                  "VIDTRACKER",
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  child: Text(
                    "These are unsettling times and COVID-19 is clearing impacting our personal and professional lives, and those that we love.Let help save life.Track,get update and report issues",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              codeSent
                  ? Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        width: 330,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: ListTile(
                          trailing: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                                color: Color(0xff0C12D8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: IconButton(
                              onPressed: () {
                                AuthService()
                                    .signInWithOTP(smsCode, verificationId,userPhone,_selected.name);
                              },
                              icon: Icon(Icons.arrow_forward),
                              color: Colors.white,
                            ),
                          ),
                          title: Container(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              onChanged: (value) {
                                setState(() {
                                  this.smsCode = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        width: 330,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: ListTile(
                          leading: CountryPicker(
                            dense: false,
                            showFlag: true, //displays flag, true by default
                            showDialingCode:
                                true, //displays dialing code, false by default
                            showName:
                                false, //displays country name, true by default
                            showCurrency: false, //eg. 'British pound'
                            showCurrencyISO: false, //eg. 'GBP'
                            onChanged: (Country country) {
                              setState(() {
                                _selected = country;
                              });
                            },
                            selectedCountry: _selected,
                          ),
                          trailing: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                                color: Color(0xff0C12D8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: IconButton(
                              onPressed: () {
                                print(userPhone);
                                verifyPhone(userPhone);
                                
                              },
                              icon: Icon(Icons.arrow_forward),
                              color: Colors.white,
                            ),
                          ),
                          title: Container(
                            child: TextFormField(
                              controller: number,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              onChanged: (value) {
                                setState(() {
                                  userPhone =
                                      '+' + _selected.dialingCode + number.text;
                                  print(userPhone);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult,userPhone,_selected.name);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
