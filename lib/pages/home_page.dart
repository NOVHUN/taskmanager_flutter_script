import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'task_form_dialog.dart';
import '../models/task_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterTasks);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterTasks() {
    setState(() {});
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
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                if (taskProvider.tasks.isEmpty) {
                  return Center(child: Text('No tasks available.'));
                }

                List<Task> tasks = taskProvider.tasks;
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

                // Separate incomplete and completed tasks
                List<Task> incompleteTasks =
                    tasks.where((task) => !task.isDone).toList();
                List<Task> completedTasks =
                    tasks.where((task) => task.isDone).toList();

                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isLandscape ? 5 : 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 2.5,
                  ),
                  itemCount: incompleteTasks.length + completedTasks.length,
                  itemBuilder: (context, index) {
                    if (index < incompleteTasks.length) {
                      return buildTaskTile(incompleteTasks[index]);
                    } else {
                      return buildTaskTile(
                          completedTasks[index - incompleteTasks.length]);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showTaskForm();
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
        elevation:
            6.0, // Slightly increased elevation for a more pronounced shadow
        margin: const EdgeInsets.all(10.0), // Add some margin around the card
        clipBehavior: Clip
            .antiAlias, // Ensures that the content does not overflow and is clipped to the border radius
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              16.0), // Increased border radius for a softer look
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: task.isDone
                  ? [Colors.green[300]!, Colors.green[100]!]
                  : [Color.fromARGB(255, 200, 161, 226), Colors.white],
              // Gradient effect from a darker to lighter shade depending on task completion
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
                20.0), // Increased padding for better spacing
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 24, // Increased font size for title
                    fontWeight: FontWeight.bold,
                    color: Colors
                        .grey[800], // Darker text color for better readability
                  ),
                ),
                SizedBox(height: 10), // Increased spacing
                Text(
                  'Start: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(task.startDate))}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Text(
                  'End: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(task.endDate))}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Text(
                  'Priority: ${task.priority}',
                  style: TextStyle(
                      fontSize: 18,
                      color:
                          Colors.red[300]), // Highlight priority with a color
                ),
                Text(
                  'Time Working: ${task.timeWorking}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Text(
                  'Duration: ${task.duration}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Text(
                  'Note: ${task.note}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Checkbox(
                    value: task.isDone,
                    onChanged: (value) {
                      // Same functionality as before but consider changing the color of the checkbox
                      setState(() {
                        task.isDone = value!;
                        Provider.of<TaskProvider>(context, listen: false)
                            .updateTask(task);
                      });
                    },
                    activeColor:
                        Colors.green[400], // Checkbox color when active
                    checkColor: Colors.white, // Color of the tick
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
