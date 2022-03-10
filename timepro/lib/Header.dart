import 'package:flutter/material.dart';

class Header extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Center(
            child: Image.asset('assets/timesmall.png', scale: 2.5,),

            //child: Text("time.", style: TextStyle(color: Colors.yellow, fontSize: 40),),
          ),
          SizedBox(height: 1,),
          Center(
            child: Text("Welcome to TimePro", style: TextStyle(color: Colors.yellow,fontSize: 18),),
          )
        ],
      ),
    );
  }
}