import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';
import 'tasks.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final Icon icon;
  MyTextField({required this.label, this.maxLines = 1, this.minLines = 1, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.yellow),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
          suffixIcon: icon == null ? null: icon,
          labelText: label,
          labelStyle: TextStyle(color: Colors.yellow),
          focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
          border:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
class MyBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'backButton',
      child: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}

class Task{
  late final String name;
  late bool isDone;

  Task({required this.name, this.isDone = false});

  void toggleDone(){
    isDone = isDone;
  }
}

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final void Function(bool?) checkboxCallback;
  final VoidCallback? longPressCallback;

  TaskTile(
      {required this.isChecked,
        required this.taskTitle,
        required this.checkboxCallback,
        required this.longPressCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback,
      title: Text(
        taskTitle,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}
class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'Buy milk'),
    Task(name: 'Buy eggs'),
    Task(name: 'Buy bread'),
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTask) {
    final task = Task(name: newTask);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: CircleAvatar(
        backgroundColor: Colors.yellow,
        radius: 30,
        child: Icon(
          icon,
          size: 36,
        ),
      ),
    );
  }
}

class taskList extends StatefulWidget{
  @override
  taskListState createState() => taskListState();
}
class taskListState extends State<taskList>{
  String uid = '';
  @override
  void initState() {
    getuid();
    super.initState();
  }
  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser as User;
    setState(() {
      uid = user.uid;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('tasks')
              .doc(uid)
              .collection('mytasks')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final docs = snapshot.data?.docs;
              return ListView.builder(
                itemCount: docs.length,
                  itemBuilder: (context, index){
                    var time = (docs[index]['timestamp'] as Timestamp).toDate();
                    return ListTile(
                      title: Text(docs["title"]),
                    );
                  }
              );
            }
          }
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  final String title, description;

  const Description({required Key key, required this.title, required this.description}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Description')),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                title,
                style: GoogleFonts.roboto(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                description,
                style: GoogleFonts.roboto(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget buildList(QuerySnapshot snapshot){
  return ListView.builder(
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index){
        final doc = snapshot.docs[index];
        return Dismissible(
            key: Key(doc.id),
        background: Container(color: Colors.red),
        onDismissed: (direction) {
        // delete the doc from the database
        FirebaseFirestore.instance.collection("tasks")
            .doc(doc.id)
            .delete();
        },
        child: ListTile(
          title: Text(doc["title"]),
          ),
        );
      }
  );
}

deleteTask(item){
  DocumentReference documentReference = FirebaseFirestore.instance.collection('tasks').doc(item);
  documentReference.delete().whenComplete(() {
    print("$item deleted");
  });
}