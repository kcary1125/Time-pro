import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'tasks.dart';
import 'dart:collection';

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
class User {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;
  final String bio;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.displayName,
    required this.bio,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      email: doc['email'],
      username: doc['username'],
      photoUrl: doc['photoUrl'],
      displayName: doc['displayName'],
      bio: doc['bio'],
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