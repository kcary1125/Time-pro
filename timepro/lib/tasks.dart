import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:timepro/home.dart';
import 'package:timepro/widgets.dart';

class CreateNewTaskPage extends StatefulWidget {
  @override
  CreateNewTaskState createState() => CreateNewTaskState();
}
class CreateNewTaskState extends State<CreateNewTaskPage>{
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  addTaskData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user =  auth.currentUser as User;
    String uid = user.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(time.toString())
        .set({
      'title': titleController.text,
      'description': descriptionController.text,
      'time': time.toString(),
      'timestamp': time
    });
    Fluttertoast.showToast(msg: 'Data Added');
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    late String newTask;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.yellow,
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/timeb2.jpg'),fit: BoxFit.fill),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Create New Task',
                        style: TextStyle(
                            color: Colors.yellow,fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //TextField(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  style: TextStyle(color: Colors.deepPurple),
                                  controller: titleController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.yellow,
                                    labelText: 'Enter Title',
                                    border: OutlineInputBorder(),),
                                ),
                              ),
                              //homeScreen().calendarIcon(),
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      TextField(
                        style: TextStyle(color: Colors.deepPurple),
                          controller: descriptionController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.yellow,
                              labelText: 'Enter Description',
                              border: OutlineInputBorder()
                          ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              alignment: Alignment.bottomCenter,
              //child: const SizedBox(height: 15),
              child: SizedBox(
                //mainAxisAlignment: MainAxisAlignment.end,
                height: 75,
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    side: const BorderSide(width: 2.0, color: Colors.deepPurple),
                    shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text("Create Task",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  onPressed: ()async{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => homeScreen()));
                    addTaskData();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
