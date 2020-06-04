import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vidtrack/providers/authservice.dart';
import 'package:vidtrack/dashboard/splashdesign.dart';

class AppSplashScreen extends StatefulWidget {
  static String id = '/';
  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    controller.forward();
    controller.addListener(() {
      setState(() {});
      print(controller.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
        child: Center(
          child: SplashScreen(
            lottie: Lottie.asset("assets/13422-loading-bloob-w-spin.json"),
            seconds: 10,
            backgroundColor: Colors.white,
            navigateAfterSeconds: AuthService().handleAuth(),
            photoSize: animation.value * 170,
            loaderColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
