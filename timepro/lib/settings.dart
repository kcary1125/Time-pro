import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class settingsScreen extends StatefulWidget {
  @override
  settingsScreenState createState() => settingsScreenState();
}

class settingsScreenState extends State<settingsScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.deepPurple,
    elevation: 1,
        ),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/timeb2.jpg'), fit: BoxFit.fill),),
        padding: const EdgeInsets.fromLTRB(60, 100, 60, 100),
        height: 1000,
        child: Text("Add some settings in future", style: TextStyle(color: Colors.yellow, fontSize: 70, fontWeight: FontWeight.bold,)),
      ),
    );
  }

}