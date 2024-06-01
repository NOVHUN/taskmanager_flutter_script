import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import '../models/task_model.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatelessWidget {
  final String reportType;

  ReportPage({required this.reportType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report By $reportType'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          List<Task> completedTasks =
              taskProvider.tasks.where((task) => task.isDone).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: completedTasks.length,
            itemBuilder: (context, index) {
              var task = completedTasks[index];
              return Card(
                elevation: 4.0,
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
