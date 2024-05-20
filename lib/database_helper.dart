import 'package:hive/hive.dart';
import 'models/task_model.dart';

class DatabaseHelper {
  static const String taskBoxName = "tasks";

  Future<void> addTask(Task task) async {
    var box = await Hive.openBox<Task>(taskBoxName);
    await box.add(task);
  }

  Future<List<Task>> getTasks() async {
    var box = await Hive.openBox<Task>(taskBoxName);
    return box.values.toList();
  }

  Future<void> updateTask(Task task) async {
    await task.save();
  }

  Future<void> deleteTask(Task task) async {
    await task.delete();
  }

  Future<void> clearAllTasks() async {
    var box = await Hive.openBox<Task>(taskBoxName);
    await box.clear();
  }
}
