import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await dbHelper.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await dbHelper.addTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await dbHelper.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(Task task) async {
    await dbHelper.deleteTask(task);
    await loadTasks();
  }

  Future<void> clearAllTasks() async {
    await dbHelper.clearAllTasks();
    await loadTasks();
  }
}
