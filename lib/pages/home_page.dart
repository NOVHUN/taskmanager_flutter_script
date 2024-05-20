import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/database_helper.dart';
import 'package:taskmanager/pages/add_task_page.dart';
import 'package:taskmanager/models/task_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  Future<List<Task>>? _taskList;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshTaskList();
    searchController.addListener(_filterTasks);
  }

  void _refreshTaskList() {
    setState(() {
      _taskList = dbHelper.getTasks();
    });
  }

  void _filterTasks() {
    setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: _taskList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No tasks available.'));
                }

                List<Task> tasks = snapshot.data!;
                String searchTerm = searchController.text.toLowerCase();
                tasks = tasks.where((task) {
                  return task.title.toLowerCase().contains(searchTerm) ||
                      task.startDate.toLowerCase().contains(searchTerm) ||
                      task.endDate.toLowerCase().contains(searchTerm) ||
                      task.priority.toLowerCase().contains(searchTerm) ||
                      task.timeWorking.toLowerCase().contains(searchTerm) ||
                      task.duration.toLowerCase().contains(searchTerm) ||
                      task.note.toLowerCase().contains(searchTerm);
                }).toList();

                List<Task> incompleteTasks =
                    tasks.where((task) => !task.isDone).toList();
                List<Task> completedTasks =
                    tasks.where((task) => task.isDone).toList();

                return ListView(
                  children: [
                    ...incompleteTasks
                        .map((task) => buildTaskTile(task))
                        .toList(),
                    Divider(),
                    ...completedTasks
                        .map((task) => buildTaskTile(task))
                        .toList(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
          if (result == true) {
            _refreshTaskList();
          }
        },
      ),
    );
  }

  Widget buildTaskTile(Task task) {
    return ListTile(
      tileColor: task.isDone ? Colors.green[100] : Colors.white,
      title: Text(task.title),
      subtitle: Text(
        'Start: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(task.startDate))}\nEnd: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(task.endDate))}\nPriority: ${task.priority}\nTime Working: ${task.timeWorking}\nDuration: ${task.duration}\nNote: ${task.note}',
      ),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: (value) {
          setState(() {
            task.isDone = value!;
            dbHelper.updateTask(task);
            _refreshTaskList();
          });
        },
      ),
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddTaskPage(task: task),
          ),
        );
        if (result == true) {
          _refreshTaskList();
        }
      },
    );
  }
}
