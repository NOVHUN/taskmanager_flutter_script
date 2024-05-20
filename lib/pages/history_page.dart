import 'package:flutter/material.dart';
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
          List<Task> tasks = snapshot.data!
              .where((task) => task.isDone)
              .toList();
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
}
