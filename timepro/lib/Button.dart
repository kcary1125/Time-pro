import 'package:flutter/material.dart';

class Button extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(60),
      ),
      child: Center(
        child: Text("Login", style: TextStyle(
          color: Colors.deepPurple,
          fontSize: 15,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}