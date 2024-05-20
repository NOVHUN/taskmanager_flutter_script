<!DOCTYPE html>
<html lang="en">
<!-- <head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Task Manager Flutter Application Documentation</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      margin: 0 auto;
      max-width: 800px;
      padding: 20px;
    }
    h1, h2 {
      color: #333;
    }
    pre {
      background: #f4f4f4;
      padding: 10px;
      border: 1px solid #ddd;
      overflow-x: auto;
    }
    code {
      background: #f4f4f4;
      padding: 2px 4px;
      border-radius: 4px;
    }
  </style>
</head> -->
<body>

<h1>Task Manager Flutter Application</h1>

<h2>Table of Contents</h2>
<ol>
  <li><a href="#introduction">Introduction</a></li>
  <li><a href="#features">Features</a></li>
  <li><a href="#project-structure">Project Structure</a></li>
  <li><a href="#setup-instructions">Setup Instructions</a></li>
  <li><a href="#running-the-application">Running the Application</a></li>
  <li><a href="#building-the-apk">Building the APK</a></li>
  <li><a href="#using-the-application">Using the Application</a></li>
  <li><a href="#storing-data-with-hive">Storing Data with Hive</a></li>
  <li><a href="#code-overview">Code Overview</a></li>
</ol>

<h2 id="introduction">Introduction</h2>
<p>The Task Manager Flutter Application is a simple yet powerful tool designed to help users manage their tasks efficiently. It allows users to add, update, and delete tasks, mark tasks as completed, and view a history of completed tasks. The app stores data locally using Hive, a lightweight and fast key-value database.</p>

<h2 id="features">Features</h2>
<ul>
  <li>Add new tasks with title, start date, end date, priority, time working, duration, and notes.</li>
  <li>Update existing tasks.</li>
  <li>Mark tasks as completed, which changes their color and moves them to the bottom of the list.</li>
  <li>View a history of completed tasks.</li>
  <li>Clear all tasks data from the settings page.</li>
</ul>

<h2 id="project-structure">Project Structure</h2>
<pre>
taskmanager/
├── android/
├── build/
├── ios/
├── lib/
│   ├── models/
│   │   ├── task_model.dart
│   ├── pages/
│   │   ├── add_task_page.dart
│   │   ├── history_page.dart
│   │   ├── home_page.dart
│   │   ├── settings_page.dart
│   ├── database_helper.dart
│   ├── hive_init.dart
│   ├── hive_init_stub.dart
│   ├── hive_init_web.dart
│   ├── main.dart
├── assets/
│   ├── image.ico
├── pubspec.yaml
├── .gitignore
</pre>

<h2 id="setup-instructions">Setup Instructions</h2>
<h3>Prerequisites</h3>
<p>Ensure you have the following installed:</p>
<ul>
  <li>Flutter SDK</li>
  <li>Android Studio or Visual Studio Code with Flutter extension</li>
  <li>Git</li>
</ul>

<h3>Installation</h3>
<ol>
  <li><strong>Clone the Repository</strong>:
    <pre><code>git clone https://github.com/your-username/TaskManagerApp.git
cd TaskManagerApp</code></pre>
  </li>
  <li><strong>Install Dependencies</strong>:
    <pre><code>flutter pub get</code></pre>
  </li>
</ol>

<h2 id="running-the-application">Running the Application</h2>
<ol>
  <li><strong>Run on Android Emulator or Physical Device</strong>:
    <pre><code>flutter run</code></pre>
  </li>
  <li><strong>Run on Web</strong>:
    <pre><code>flutter run -d chrome</code></pre>
  </li>
</ol>

<h2 id="building-the-apk">Building the APK</h2>
<ol>
  <li><strong>Prepare for Release</strong>:
    <ul>
      <li>Ensure you have the necessary configurations in <code>android/app/build.gradle</code>.</li>
      <li>Create a keystore and add it to your project.</li>
    </ul>
  </li>
  <li><strong>Build the APK</strong>:
    <pre><code>flutter build apk --release</code></pre>
  </li>
  <li><strong>Locate the APK</strong>:
    <ul>
      <li>The generated APK can be found in <code>build/app/outputs/flutter-apk</code>.</li>
    </ul>
  </li>
</ol>

<h2 id="using-the-application">Using the Application</h2>
<ol>
  <li><strong>Home Page</strong>:
    <ul>
      <li>View all tasks.</li>
      <li>Tasks are color-coded based on completion status.</li>
      <li>Incomplete tasks are shown at the top, and completed tasks at the bottom.</li>
      <li>Tap a task to update it.</li>
    </ul>
  </li>
  <li><strong>Add Task Page</strong>:
    <ul>
      <li>Fill in the task details: title, start date, end date, priority, time working, duration (auto-calculated), and notes.</li>
      <li>Save the task.</li>
    </ul>
  </li>
  <li><strong>History Page</strong>:
    <ul>
      <li>View completed tasks.</li>
      <li>Restore tasks back to the main list.</li>
    </ul>
  </li>
  <li><strong>Settings Page</strong>:
    <ul>
      <li>View app version.</li>
      <li>Clear all tasks data.</li>
      <li>View terms and conditions, and privacy policy.</li>
    </ul>
  </li>
</ol>

<h2 id="storing-data-with-hive">Storing Data with Hive</h2>
<p>Hive is used for storing task data locally. The following files handle data operations:</p>
<ol>
  <li><strong>Task Model</strong>: <code>lib/models/task_model.dart</code>
    <pre><code>import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String startDate;

  @HiveField(2)
  late String endDate;

  @HiveField(3)
  late String priority;

  @HiveField(4)
  late bool isDone;

  @HiveField(5)
  late String timeWorking;

  @HiveField(6)
  late String duration;

  @HiveField(7)
  late String note;

  Task({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.priority,
    required this.timeWorking,
    required this.duration,
    required this.note,
    this.isDone = false,
  });
}</code></pre>
  </li>
  <li><strong>Database Helper</strong>: <code>lib/database_helper.dart</code>
    <pre><code>import 'package:hive/hive.dart';
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
}</code></pre>
  </li>
</ol>

<h2 id="code-overview">Code Overview</h2>
<h3>Main Application</h3>
<pre><code>import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskmanager/pages/add_task_page.dart';
import 'package:taskmanager/pages/history_page.dart';
import 'package:taskmanager/pages/home_page.dart';
import 'package:taskmanager/pages/settings_page.dart';
import 'package:taskmanager/models/task_model.dart';
import 'hive_init_stub.dart' if (dart.library.html) 'hive_init_web.dart' if (dart.library.io) 'hive_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>(DatabaseHelper.taskBoxName);

  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/add-task': (context) => AddTaskPage(),
        '/history': (context) => HistoryPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}</code></pre>

<h3>Home Page</h3>
<pre><code>import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/database_helper.dart';
import 'package:taskmanager/models/task_model.dart';
import 'package:taskmanager/pages/add_task_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text('TaskManager'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, '/history'),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: FutureBuilder<List<Task>>(
        future: dbHelper.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tasks available.'));
          }
          List<Task> tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              var task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(
                  'Start: ${task.startDate}\nEnd: ${task.endDate}\nPriority: ${task.priority}',
                ),
                trailing: Checkbox(
                  value: task.isDone,
                  onChanged: (value) {
                    setState(() {
                      task.isDone = value!;
                      dbHelper.updateTask(task);
                    });
                  },
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaskPage(task: task),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/add-task'),
      ),
    );
  }
}</code></pre>

<h3>Add Task Page</h3>
<pre><code>import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/database_helper.dart';
import 'package:taskmanager/models/task_model.dart';

class AddTaskPage extends StatefulWidget {
  final Task? task;

  AddTaskPage({this.task});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _priority;
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _startDate = DateFormat('yyyy-MM-dd').parse(widget.task!.startDate);
      _endDate = DateFormat('yyyy-MM-dd').parse(widget.task!.endDate);
      _priority = widget.task!.priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Start Date'),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _startDate) {
                    setState(() {
                      _startDate = picked;
                    });
                  }
                },
                readOnly: true,
                controller: TextEditingController(
                  text: _startDate == null
                      ? ''
                      : DateFormat('yyyy-MM-dd').format(_startDate!),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'End Date'),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _endDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _endDate) {
                    setState(() {
                      _endDate = picked;
                    });
                  }
                },
                readOnly: true,
                controller: TextEditingController(
                  text: _endDate == null
                      ? ''
                      : DateFormat('yyyy-MM-dd').format(_endDate!),
                ),
              ),
              DropdownButtonFormField(
                value: _priority,
                items: ['Low', 'Medium', 'High'].map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value as String?;
                  });
                },
                decoration: InputDecoration(labelText: 'Priority'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var task = Task(
                      title: _titleController.text,
                      startDate: DateFormat('yyyy-MM-dd').format(_startDate!),
                      endDate: DateFormat('yyyy-MM-dd').format(_endDate!),
                      priority: _priority!,
                      isDone: widget.task?.isDone ?? false,
                      timeWorking: '',
                      duration: '',
                      note: '',
                    );
                    if (widget.task == null) {
                      await dbHelper.addTask(task);
                    } else {
                      task.key = widget.task!.key;  // Preserve the key for Hive update
                      await dbHelper.updateTask(task);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.task == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}</code></pre>

<h3>History Page</h3>
<pre><code>import 'package:flutter/material.dart';
import 'package:taskmanager/database_helper.dart';
import 'package:taskmanager/models/task_model.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: FutureBuilder<List<Task>>(
        future: dbHelper.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No completed tasks.'));
          }
          List<Task> tasks = snapshot.data!.where((task) => task.isDone).toList();
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              var task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(
                  'Start: ${task.startDate}\nEnd: ${task.endDate}\nPriority: ${task.priority}',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    setState(() {
                      task.isDone = false;
                      dbHelper.updateTask(task);
                    });
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () async {
          await dbHelper.clearAllTasks();
          setState(() {});
        },
      ),
    );
  }
}</code></pre>

<h3>Settings Page</h3>
<pre><code>import 'package:flutter/material.dart';
import 'package:taskmanager/database_helper.dart';

class SettingsPage extends StatelessWidget {
  final String version = '1.0.0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Wespaces.png', height: 100), // Correct path
              SizedBox(height: 20),
              Text('Version: $version'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper().clearAllTasks();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('All data cleared')),
                  );
                },
                child: Text('Clear All Data'),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Navigate to terms and conditions page
                },
                child: Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Navigate to privacy policy page
                },
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Powered By Wespaces Team', textAlign: TextAlign.center),
      ),
    );
  }
}</code></pre>

<h3>Database Helper</h3>
<pre><code>import 'package:hive/hive.dart';
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
}</code></pre>

<h3>Hive Initialization</h3>
<p><code>hive_init.dart</code></p>
<pre><code>import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/task_model.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
}</code></pre>

<p><code>hive_init_stub.dart</code></p>
<pre><code>Future<void> initHive() async {
  // Stub for web, should not be called
  throw UnsupportedError('Cannot initialize Hive on this platform');
}</code></pre>

<p><code>hive_init_web.dart</code></p>
<pre><code>import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/task_model.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
}</code></pre>

<h3>Main Dart File</h3>
<pre><code>import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskmanager/pages/add_task_page.dart';
import 'package:taskmanager/pages/history_page.dart';
import 'package:taskmanager/pages/home_page.dart';
import 'package:taskmanager/pages/settings_page.dart';
import 'package:taskmanager/models/task_model.dart';
import 'hive_init_stub.dart' if (dart.library.html) 'hive_init_web.dart' if (dart.library.io) 'hive_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/add-task': (context) => AddTaskPage(),
        '/history': (context) => HistoryPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}</code></pre>

</body>
</html>
