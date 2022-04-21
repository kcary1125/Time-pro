import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timepro/profile.dart';
import 'package:timepro/remind.dart';
import 'package:timepro/settings.dart';
import 'package:timepro/tasklist.dart';
import 'package:timepro/tasks.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timepro/timerr.dart';
import 'package:timepro/widgets.dart';
import 'calendar.dart';
import 'moti.dart';

class homeScreen extends StatefulWidget {
  @override
  homeScreenState createState() => homeScreenState();
}

class homeScreenState extends State<homeScreen> {
  List todos = List.empty();
  String filterType = "today";
  DateTime today = new DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String taskPop  = "close";
  var monthNames = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEPT", "OCT", "NOV", "DEC"];
  //late final controller= CalendarController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset : false,
      body: Stack(
        children: [
          //Image.asset('assets/timeb2.jpg', fit:BoxFit.fill,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Colors.deepPurple,
                elevation: 0,
                title: Text("TimePro", style: TextStyle(
                    fontSize: 30
                ),),
                actions: [
                  IconButton(
                    icon: Icon(Icons.settings,
                      color: Colors.yellow,
                      size: 30,
                    ), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => settingsScreen())); },
                  ),
                  IconButton(
                    icon: Icon(Icons.announcement_outlined,
                      color: Colors.yellow,
                      size: 30,
                    ), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => motiScreen())); },
                  ),
                  IconButton(
                    icon: Icon(Icons.doorbell_outlined,
                      color: Colors.yellow,
                      size: 30,
                    ), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => addReminderPage())); },
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today_outlined,
                        color: Colors.yellow,
                        size: 30), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => calScreen())); },
                  )
                ],
              ),
              /*
                Expanded(
                  child: SingleChildScrollView(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('mytasks').snapshots(),
                        builder: (context, snapshots) {
                          return ListView.builder(
                              itemCount: snapshots.data?.docs.length,
                              itemBuilder: (context, index){
                                DocumentSnapshot documentSnapshot = snapshots.data?.docs[index] as DocumentSnapshot<Object?>;
                                return Dismissible(key: Key(index.toString()),
                                  child: Card(
                                    elevation: 0,
                                    margin: EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: ListTile(
                                      title: Text(documentSnapshot['title']),
                                      trailing: IconButton(
                                          icon: Icon(Icons.delete, color: Colors.yellow),
                                          onPressed: (){
                                            deleteTask(documentSnapshot['title']);
                                          }
                                      ),
                                    ),
                                  ),
                                );
                              }
                          );
                        }
                    ),
                ),
                    ),

                 */
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 110,
                      child: Stack(
                        children: [
                          //Image.asset('assets/timeb2.jpg', fit:BoxFit.cover,),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.deepPurple,
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        color: Colors.yellow,
                                        icon : Icon(Icons.account_box_outlined),
                                        onPressed: () async{Navigator.push(context, MaterialPageRoute(builder: (context) => profileScreen()));},
                                      ),
                                      Text(
                                        "Profile",
                                        style: TextStyle(color: Colors.yellow),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        color: Colors.yellow,
                                        icon : Icon(Icons.timer_outlined),
                                        onPressed: () async{Navigator.push(context, MaterialPageRoute(builder: (context) => timerScreen()));},
                                      ),
                                      Text(
                                        "Timer",
                                        style: TextStyle(color: Colors.yellow),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: IconButton(
                              color: Colors.yellow,
                              icon: Icon(Icons.add),
                              onPressed: ()async{openNewTask();},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
              ),
            ],
          ),
        ],
      ),
    );
  }

  changeFilter(String filter)
  {
    filterType = filter;
    setState(() {

    });
  }
  openNewTask()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewTaskPage()));
  }

}