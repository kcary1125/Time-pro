import 'package:flutter/material.dart';
import 'login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset('assets/timesmall.png'),
        nextScreen: loginPage(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.deepPurple,
        //pageTransitionType: pageTransitionType.scale,
      //home: LoginPage(),
      ),
    );
  }
}