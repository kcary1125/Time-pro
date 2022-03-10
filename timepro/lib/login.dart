import 'package:flutter/material.dart';
import 'InputWrapper.dart';
import 'Header.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset : false,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image:AssetImage('assets/timeb2.jpg'),
                fit: BoxFit.fill),
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.deepPurple[800]!,
              Colors.deepPurple[900]!,
              Colors.deepPurple[900]!
            ]),
          ),
          child: Column(
            children:<Widget> [
              const SizedBox(height: 80,),
              Header(),
              Expanded(child: Container(
                decoration: const BoxDecoration(
                  //color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                ),
                child: InputWrapper(),
              ))
            ],
          ),
        ),
    );
  }
}