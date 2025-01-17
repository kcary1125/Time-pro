import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timepro/settings.dart';

import 'home.dart';
import 'login.dart';


class profileScreen extends StatefulWidget {
  @override
  profileScreenState createState() => profileScreenState();
}

class profileScreenState extends State<profileScreen>{
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset('assets/timeb2.jpg', fit:BoxFit.cover,),
        Scaffold(
          backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset : false,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            elevation: 1,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.yellow,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => homeScreen()));
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.yellow,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => settingsScreen()));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.logout_outlined,
                      color: Colors.yellow
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => loginPage()));
                },
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.yellow,fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context).scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.yellow.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "",
                                  ))),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: Colors.deepPurple,
                                ),
                                color: Colors.yellow,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.yellow,
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  buildTextField("Name","name" , true),
                  buildTextField("E-mail", "email", true),
                  buildTextField("Password", "password", true),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => homeScreen()));},
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.yellow)),
                      ),
                      RaisedButton(
                        onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => homeScreen()));},
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.yellow),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.yellow,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.yellow,
            )),
      ),
    );
  }
}
