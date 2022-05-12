import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timepro/home.dart';
import 'login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'notif.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();


  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
        //nextScreen: loginPage(),
          nextScreen: homeScreen(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.deepPurple,
        //pageTransitionType: pageTransitionType.scale,
      //home: LoginPage(),
      ),
    );
  }
}
