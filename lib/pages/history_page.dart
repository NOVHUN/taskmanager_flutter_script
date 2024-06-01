import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'task_form_dialog.dart';
import '../models/task_model.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  void _showTaskForm({Task? task}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TaskFormDialog(
          task: task,
          onSave: () {
            Provider.of<TaskProvider>(context, listen: false).loadTasks();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var isLandscape = orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          List<Task> completedTasks =
              taskProvider.tasks.where((task) => task.isDone).toList();

          if (completedTasks.isEmpty) {
            return Center(child: Text('No completed tasks.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isLandscape ? 5 : 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 2,
            ),
            itemCount: completedTasks.length,
            itemBuilder: (context, index) {
              return buildTaskTile(completedTasks[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () async {
          await Provider.of<TaskProvider>(context, listen: false)
              .clearAllTasks();
        },
      ),
    );
  }

  Widget buildTaskTile(Task task) {
    return GestureDetector(
      onTap: () {
        _showTaskForm(task: task);
      },
      child: Card(
        elevation: 4.0,
        color: task.isDone ? Colors.green[100] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Start: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(task.startDate))}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Text(
                'End: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(task.endDate))}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Text(
                'Priority: ${task.priority}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Text(
                'Time Working: ${task.timeWorking}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Text(
                'Duration: ${task.duration}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Text(
                'Note: ${task.note}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.restore),
                    onPressed: () {
                      task.isDone = false;
                      Provider.of<TaskProvider>(context, listen: false)
                          .updateTask(task);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Provider.of<TaskProvider>(context, listen: false)
                          .deleteTask(task);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
