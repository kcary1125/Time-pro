import 'dart:core';
import 'dart:core';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:timepro/home.dart';
import 'package:timepro/taskcontrol.dart';
import 'package:timepro/widgets.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

enum options { daily, onSpecificDays }

class CreateNewTaskPage extends StatefulWidget {
  @override
  CreateNewTaskState createState() => CreateNewTaskState();
}
class CreateNewTaskState extends State<CreateNewTaskPage>{
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _taskController = Get.put(taskController());
  //final taskController _taskController = Get.put(taskController());
  DateTime _selectedDate = DateTime.now();
  options radioButtonValue = options.daily;
  //String currTask = '';
  //late int id;
  List<TimeOfDay> reminders = [];
  TimeOfDay selectedTime = TimeOfDay.now();
  String dropdownValue = 'Days';
  bool remindMe = false;
  TimeOfDay reminderTime= TimeOfDay.now();
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String? _selectedRepeat = 'None';
  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];

  bool isNoneSelected = false;
  bool isWeeklySelected = false;
  bool isMonthlySelected = false;
/*
  bool isWedSelected = false;
  bool isThuSelected = false;
  bool isFriSelected = false;
  bool isSatSelected = false;
 */
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  @override
  void initState() {
    super.initState();
    //todos = ["", ""];
  }
  addTaskData() async {
    final DocumentReference documentReference =

    FirebaseFirestore.instance.collection("tasks").add(
      {
        "title": titleController.text,
        "description": descriptionController.text,
      }
    ) as DocumentReference<Object?>;
/*
    final Map<String, String> todoList = {
      "title": titleController.text,
      "description": descriptionController.text,
    };


    documentReference
        .set(todoList);

 */
    Fluttertoast.showToast(msg: 'Data Added');
  }
  _addTaskToDB() async{
    await _taskController.addTask(
      task: Task(
          title: titleController.text,
          description: descriptionController.text,
          date: DateFormat.yMd().format(_selectedDate),
          remind: _selectedRemind,
          repeat: _selectedRepeat,
          //isCompleted: 0;
      ),
    );
  }
  /*
  _validateInputs() {
    if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
      _addTaskToDB();
      Get.back();
    } else if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All fields are required.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      print("ERROR");
    }
  }
   */
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
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
                      SizedBox(height: _screenSize.height * 0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Date',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          ),
                          Container(
                            height: _screenSize.height * 0.06,
                            // padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.yellow),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    _selectedDate == null
                                        ? 'No Date Chosen!'
                                        : DateFormat.yMd().format(_selectedDate),
                                    style: TextStyle(color: Colors.yellow,),
                                  ),
                                ),
                                IconButton(
                                  onPressed: _getDateFromUser,
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    color: Colors.yellow,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        height: _screenSize.height * 0.02,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Time',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow,
                              ),
                            ),
                          ]
                      ),
                      Divider(
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        height: _screenSize.height * 0.02,
                      ),
                      Row(
                        children: [
                          Text(
                            'Frequency',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.yellow,
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: _screenSize.height * 0.05,
                            child: ListTile(
                              title: const Text('Daily', style: TextStyle(color: Colors.yellow,),),
                              leading: Radio<options>(
                                materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                                value: options.daily,
                                groupValue: radioButtonValue,
                                onChanged: (options? value) {
                                  setState(() {
                                    radioButtonValue = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _screenSize.height * 0.05,
                            child: ListTile(
                              title: const Text('On Specific Days', style: TextStyle(color: Colors.yellow,),),
                              leading: Radio<options>(
                                materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                                value: options.onSpecificDays,
                                groupValue: radioButtonValue,
                                onChanged: (options? value) {
                                  setState(() {
                                    radioButtonValue = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _screenSize.height * 0.03,
                      ),
                      if (radioButtonValue == options.onSpecificDays)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 34,
                              width: 105,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.yellow),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: ChoiceChip(
                                backgroundColor: Colors.deepPurple,
                                onSelected: (value) => setState(() {
                                  isNoneSelected = value;
                                }),
                                label: const Text("None", style: TextStyle(color: Colors.yellow,),),
                                selected: isNoneSelected,
                              ),
                            ),
                            Container(
                              height: 34,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.yellow),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: ChoiceChip(
                                backgroundColor: Colors.deepPurple,
                                onSelected: (value) => setState(() {
                                  isWeeklySelected = value;
                                }),
                                label: const Text('Weekly', style: TextStyle(color: Colors.yellow,),),
                                selected: isWeeklySelected,
                              ),
                            ),
                            Container(
                              height: 34,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.yellow),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: ChoiceChip(
                                backgroundColor: Colors.deepPurple,
                                onSelected: (value) => setState(() {
                                  isMonthlySelected = value;
                                }),
                                label: const Text('Monthly', style: TextStyle(color: Colors.yellow,),),
                                selected: isMonthlySelected,
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: _screenSize.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Task Reminder',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          ),
                          RawMaterialButton(
                            onPressed: () async {
                              _getTimeFromUser(isStartTime: true);
                              setState(() {

                              });

                              await showTimePicker(
                                initialEntryMode: TimePickerEntryMode.input,
                                initialTime: selectedTime,
                                context: context,
                                builder: (context, theChild) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
                                    child: theChild!,
                                  );
                                },
                              ).then((value) {
                                if (value != null) {
                                  selectedTime = value;
                                  reminders.add(value);
                                  setState(() {});
                                }
                              });
                            },
                            elevation: 2.0,
                            fillColor: Colors.deepPurple,
                            child: Icon(
                              Icons.add,
                              size: 20.0,
                              color: Colors.yellow,
                            ),
                            // padding: EdgeInsets.all(10.0),
                            shape: const CircleBorder(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: _screenSize.height * 0.02,
                      ),
                      SizedBox(
                        height: _screenSize.height * 0.15,
                        width: _screenSize.width * 0.7,
                        child: ListView.builder(
                            itemCount: reminders.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                height: _screenSize.height * 0.03,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.yellow),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Center(
                                  child: Text(
                                    reminders[index].format(context),
                                    style: TextStyle(color: Colors.yellow,),//Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                              );
                            }),
                      ),
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
                    //_validateInputs();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => homeScreen()));
                    addTaskData();
                    _addTaskToDB();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  String to24hours(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hour.toString().padLeft(2, "0");
    final min = timeOfDay.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
  _getTimeFromUser({required bool isStartTime}) async{
    var _pickedTime = await _showTimePicker();
    print(_pickedTime.format(context));
    String? _formatedTime = _pickedTime.format(context);
    print(_formatedTime);
    if (_pickedTime == null)
      print("time canceled");
    else if (isStartTime)
      setState(() {
        _startTime = _formatedTime!;
      });
  }
  _showTimePicker() async {
    return showTimePicker(
      initialTime: TimeOfDay(
          hour: int.parse(_startTime!.split(":")[0]),
          minute: int.parse(_startTime!.split(":")[1].split(" ")[0])),
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
    );
  }

  _getDateFromUser() async {
    final DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate:DateTime(2022),
        lastDate: DateTime(2099)
    );
    if(_pickerDate!=null){
      setState(() {
        _selectedDate=_pickerDate;
        print(_selectedDate);
      });
    }else{
      print("Something is Wrong");
    }
  }
}

