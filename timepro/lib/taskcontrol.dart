import 'package:get/get.dart';
import 'package:timepro/widgets.dart';
import 'package:sqflite/sqflite.dart';

import 'dbhelper.dart';

class taskController extends  GetxController{
  @override
  void onReady(){
    super.onReady();
  }
  final RxList<Task> taskList = List<Task>.empty().obs;


  Future<void> addTask({required Task task}) async {
    await DBHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int? id) async {
    await DBHelper.update(id);
    getTasks();
  }
}

