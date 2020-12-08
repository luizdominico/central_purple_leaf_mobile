import 'package:central_purple_leaf/screens/dashboard/dashboard.dart';
import 'package:central_purple_leaf/screens/login/login.dart';
import 'package:central_purple_leaf/screens/product/product.dart';
import 'package:central_purple_leaf/screens/signup/signup.dart';
import 'package:central_purple_leaf/screens/splash/splash.dart';
import 'package:flutter/material.dart';

class PurpleLeaf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => Splash(),
        '/login': (context) => Login(),
        '/signUp': (context) => SignUp(),
        '/dashboard': (context) => Dashboard(),
        '/product': (context) => Product()
      }
    );
  }
}