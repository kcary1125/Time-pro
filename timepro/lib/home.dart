import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:timepro/profile.dart';
import 'package:timepro/remind.dart';
import 'package:timepro/settings.dart';
import 'package:timepro/taskcontrol.dart';
import 'package:timepro/tasks.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timepro/timerr.dart';
import 'package:timepro/widgets.dart';
import 'calendar.dart';
import 'moti.dart';
import 'package:intl/intl.dart';

class homeScreen extends StatefulWidget {
  @override
  homeScreenState createState() => homeScreenState();
}

class homeScreenState extends State<homeScreen> {
  final _taskController = Get.put(taskController());
  DateTime _selectedDate = DateTime.now();
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
        backgroundColor: Colors.black ,
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
            ),
          ],
        ),
      /*
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
                              deleteTask(((documentSnapshot != null) ? (documentSnapshot["title"]) : ""));
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

       */

        body: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _addTaskBar(),
                _addDateBar(),
                //showTasks(),
              ],
            ),
            showTasks(),
          ],
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

  openNewTask()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewTaskPage()));
  }

}

_addTaskBar(){
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      children: [
        Text("Today", style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 30),),
      ],
    ),
  );
}

_addDateBar(){
  DateTime _selectedDate = DateTime.now();
  return Expanded(
    child: Column(
      //alignment: Alignment.topLeft,
      //margin: const EdgeInsets.only(top: 0 ),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DatePicker(
          DateTime.now(),
          height: 100,
          width: 70,
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.yellow,
          selectedTextColor: Colors.deepPurple,
          dateTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
          dayTextStyle: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
          monthTextStyle: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
          onDateChange: (date){
            _selectedDate=date;
          },
        ),
      ],
    ),
  );
}
  showTasks(){
    final taskController _taskController = Get.put(taskController());
    DateTime _selectedDate = DateTime.now();
    return Expanded(
      child: Obx((){
        if (_taskController.taskList.isEmpty){
          return _noTaskMsg();
        } else {
          return ListView.builder(
              itemCount: _taskController.taskList.length,
              itemBuilder: (context, index){
                Task task = _taskController.taskList[index];
                if (task.repeat == 'Daily'){
                  var hour= task.remind.toString().split(":")[0];
                  var minutes = task.remind.toString().split(":")[1];
                  debugPrint("My time is "+hour);
                  debugPrint("My minute is "+minutes);
                  DateTime date= DateFormat.jm().parse(task.date!);
                  var myTime = DateFormat("HH:mm").format(date);

                  return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 1375),
                      child: SlideAnimation(
                          horizontalOffset: 300.0,
                          child: FadeInAnimation(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        //showBottomSheet(context, task);
                                      },
                                      child: TaskTile(task)),
                                ],
                              ),
                          )
                      )
                  );
                }
                if (task.date == DateFormat.yMd().format(_selectedDate)){
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                      horizontalOffset: 300.0,
                      child: FadeInAnimation(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  //showBottomSheet(context, task);
                                },
                                child: TaskTile(task)),
                          ],
                        ),
                      ),
                    ),
                  );
                } else{
                  return Container();
                }
              }
          );
        }
      }
      ),
    );
  }

  _noTaskMsg(){
  return Stack(
    children: [AnimatedPositioned(
      duration: Duration(milliseconds: 2000),
      //left: left,
      //top: top,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Image.asset('assets/timesmall.png', height: 200, width: 200,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
              child: Text(
                "You do not have any tasks yet!\nAdd new tasks to make your day productive.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    )
    ],
  );
}
