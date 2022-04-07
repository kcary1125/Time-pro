import 'package:flutter/material.dart';


class timerScreen extends StatefulWidget {
  @override
  timerScreenState createState() => timerScreenState();
}

class timerScreenState extends State<timerScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 1,
      ),
    );
  }
}