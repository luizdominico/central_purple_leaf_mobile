import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:central_purple_leaf/screens/login/login.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(
    children: [
      SplashScreen(
        seconds: 5,
        backgroundColor: Colors.deepPurple,
        navigateAfterSeconds: Login(),
        loaderColor: Colors.transparent,
      ),
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.none
            )
        ),
      )
    ],
  );
}
