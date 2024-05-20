import 'package:flutter/material.dart';
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
  final _timeWorkingController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _priority;
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _timeWorkingController.text = widget.task!.timeWorking;
      _noteController.text = widget.task!.note;
      _startDate = DateFormat('yyyy-MM-dd').parse(widget.task!.startDate);
      _endDate = DateFormat('yyyy-MM-dd').parse(widget.task!.endDate);
      _priority = widget.task!.priority;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _timeWorkingController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  String _calculateDuration(DateTime start, DateTime end) {
    final duration = end.difference(start);
    return "${duration.inDays} days";
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
                  if (value == null || value.isEmpty) {
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
              DropdownButtonFormField<String>(
                value: _priority,
                items: ['Low', 'Medium', 'High'].map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Priority'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a priority';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _timeWorkingController,
                decoration: InputDecoration(labelText: 'Time Working'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter time working';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(labelText: 'Note'),
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
                      timeWorking: _timeWorkingController.text,
                      duration: _calculateDuration(_startDate!, _endDate!),
                      note: _noteController.text,
                      isDone: widget.task?.isDone ?? false,
                    );
                    if (widget.task == null) {
                      await dbHelper.addTask(task);
                    } else {
                      task..title = _titleController.text
                          ..startDate = DateFormat('yyyy-MM-dd').format(_startDate!)
                          ..endDate = DateFormat('yyyy-MM-dd').format(_endDate!)
                          ..priority = _priority!
                          ..timeWorking = _timeWorkingController.text
                          ..duration = _calculateDuration(_startDate!, _endDate!)
                          ..note = _noteController.text;
                      await dbHelper.updateTask(task);
                    }
                    Navigator.pop(context, true);  // Return true to indicate a change
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
}
