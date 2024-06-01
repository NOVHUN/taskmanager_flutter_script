import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';
import 'task_provider.dart';

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
  final _timeWorkingController = TextEditingController();
  final _durationController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _startDate = DateTime.parse(widget.task!.startDate);
      _endDate = DateTime.parse(widget.task!.endDate);
      _priority = widget.task!.priority;
      _timeWorkingController.text = widget.task!.timeWorking;
      _durationController.text = widget.task!.duration;
      _noteController.text = widget.task!.note;
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
          child: SingleChildScrollView(
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
                TextFormField(
                  controller: _timeWorkingController,
                  decoration: InputDecoration(labelText: 'Time Working'),
                ),
                TextFormField(
                  controller: _durationController,
                  decoration: InputDecoration(labelText: 'Duration'),
                ),
                TextFormField(
                  controller: _noteController,
                  decoration: InputDecoration(labelText: 'Note'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var task = Task(
                        title: _titleController.text,
                        startDate: DateFormat('yyyy-MM-dd').format(_startDate!),
                        endDate: DateFormat('yyyy-MM-dd').format(_endDate!),
                        priority: _priority!,
                        timeWorking: _timeWorkingController.text,
                        duration: _durationController.text,
                        note: _noteController.text,
                        isDone: widget.task?.isDone ?? false,
                      );
                      if (widget.task == null) {
                        Provider.of<TaskProvider>(context, listen: false)
                            .addTask(task);
                      } else {
                        task.save(); // Update task in Hive
                      }
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text(widget.task == null ? 'Add' : 'Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
