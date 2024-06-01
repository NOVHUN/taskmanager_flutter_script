import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'task_provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _selectedFilter = 'day'; // Default filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Task Completion Status',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            DropdownButton<String>(
              value: _selectedFilter,
              items: <String>['day', 'week', 'month', 'year']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toUpperCase()),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedFilter = newValue!;
                });
              },
            ),
            Expanded(
              child: Consumer<TaskProvider>(
                builder: (context, taskProvider, child) {
                  int completedTasks =
                      taskProvider.tasks.where((task) => task.isDone).length;
                  int incompleteTasks =
                      taskProvider.tasks.length - completedTasks;

                  if (taskProvider.tasks.isEmpty) {
                    return Center(
                      child: Text('No Data Available',
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: Colors.green,
                            value: completedTasks.toDouble(),
                            title: '$completedTasks\nCompleted',
                            radius: 50,
                            titleStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.red,
                            value: incompleteTasks.toDouble(),
                            title: '$incompleteTasks\nIncomplete',
                            radius: 50,
                            titleStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        sectionsSpace: 4,
                        centerSpaceRadius: 40,
                        pieTouchData:
                            PieTouchData(touchCallback: (pieTouchResponse) {
                          // Handle touch events if necessary
                        }),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
