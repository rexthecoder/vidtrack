import 'package:flutter/material.dart';
import 'package:vidtrack/dashboard/splashscreen.dart';



void main() {
  runApp(
   MaterialApp(
     debugShowCheckedModeBanner: false,

     initialRoute: AppSplashScreen.id,
     routes: {
       AppSplashScreen.id : (BuildContext context) => AppSplashScreen()
     },
   )
  );
}