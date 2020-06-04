import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vidtrack/dashboard/home.dart';
import 'package:vidtrack/dashboard/signin.dart';

class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else {
            return SignIn();
          }
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds, String userPhone, String userCountry) {
    FirebaseAuth.instance.signInWithCredential(authCreds).then((authResult) =>
        Firestore.instance
            .collection("users")
            .document(authResult.user.uid)
            .setData({
          "uid": authResult.user.uid,
          "phoneNumber": userPhone,
          "blueAdreess": '',
          "contactList" : [],
          "CountryName": userCountry,

        }));
  }

  signInWithOTP(smsCode, verId,userPhone,userCountry) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds,userPhone,userCountry);
  }
}
