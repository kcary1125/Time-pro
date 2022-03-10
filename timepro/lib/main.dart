import 'package:flutter/material.dart';
import 'login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset('assets/time.png'),
        nextScreen: LoginPage(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.deepPurple,
        //pageTransitionType: pageTransitionType.scale,
      //home: LoginPage(),
      ),
    );
  }
}