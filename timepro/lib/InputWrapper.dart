import 'package:flutter/material.dart';
import 'InputField.dart';
import 'Button.dart';

class InputWrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: <Widget> [
          const SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(20)
            ),
            child: InputField(),
          ),
          const SizedBox(height:30,),
          const Text('Remember Me',style: TextStyle(color: Colors.yellow),),
          TextButton(onPressed:(/*forgot pass screen*/){

          }, child: const Text('Forgot Password', style: TextStyle(color: Colors.yellow),
          ),),
          TextButton(onPressed:(/*create account screen*/){

          }, child: const Text('Create Account', style: TextStyle(color: Colors.yellow),),),

          const SizedBox(height: 30,),
          Button()
        ],
      ),
    );
  }
}