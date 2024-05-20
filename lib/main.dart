import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskmanager/pages/add_task_page.dart';
import 'package:taskmanager/pages/history_page.dart';
import 'package:taskmanager/pages/home_page.dart';
import 'package:taskmanager/pages/settings_page.dart';
import 'package:taskmanager/models/task_model.dart';
import 'hive_init_stub.dart'
    if (dart.library.html) 'hive_init_web.dart'
    if (dart.library.io) 'hive_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHive();

  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/add-task': (context) => AddTaskPage(),
        '/history': (context) => HistoryPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
