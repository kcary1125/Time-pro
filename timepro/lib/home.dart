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
      appBar: AppBar(
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
          builder: (context, snapshot){
          if (snapshot.hasError){
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null){
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index){
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                  snapshot.data?.docs[index];
                  //DocumentSnapshot documentSnapshot = snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                  return Dismissible(
                    key: Key(index.toString()),
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        tileColor: Colors.deepPurple,
                        title: Text((documentSnapshot != null) ? (documentSnapshot["title"]) : ""),
                        subtitle: Text((documentSnapshot != null)
                            ? ((documentSnapshot["description"] != null)
                            ? documentSnapshot["description"]
                            : "")
                            : ""),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.yellow,
                          onPressed: () {
                            setState(() {
                              deleteTask((documentSnapshot != null) ? (documentSnapshot["title"]) : "");
                            });
                          },
                        ),
                      ),
                    ),
                    //title: Text(documentSnapshot['title']),
                    //subtitle: Text(documentSnapshot['description']),
                  );
                }
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.yellow,
              ),
            ),
          );
          },
          //Image.asset('assets/timeb2.jpg', fit:BoxFit.fill,),
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
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          iconSize: 35,
          selectedIconTheme: IconThemeData(color: Colors.yellow, size: 35),
          selectedItemColor: Colors.yellow,
          unselectedIconTheme: IconThemeData(
            color: Colors.yellow,
          ),
          unselectedItemColor: Colors.yellow,
        backgroundColor: Colors.deepPurple,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.person_outline), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => profileScreen())); },
            ),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.add), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewTaskPage())); },
            ),
            label: "Add Task",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.timer_outlined), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => timerScreen())); },
            ),
            label: "Timer",
          ),
        ]
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