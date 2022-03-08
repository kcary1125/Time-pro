import 'package:flutter/material.dart';

class InputField extends StatelessWidget{
  bool hidePass = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children:<Widget> [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.deepPurple[900]!)
            )
          ),
          child: const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.deepPurple),
              border: InputBorder.none
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.deepPurple[900]!)
              )
          ),
          child: TextField(
            obscureText: hidePass,
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: (){
                    hidePass=!hidePass;
                  },
                  child: Icon(hidePass
                  ? Icons.visibility
                  : Icons.visibility_off),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.deepPurple),
                border: InputBorder.none
            ),
          ),
        ),
      ],
    );
  }
  /*
  void passView(){
    if (hidePass==true){
      hidePass=false;
    }else{
      hidePass=true;
    }
  }

   */
}