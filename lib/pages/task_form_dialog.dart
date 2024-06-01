import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import '../models/task_model.dart';

class TaskFormDialog extends StatefulWidget {
  final Task? task;
  final VoidCallback onSave;

  TaskFormDialog({this.task, required this.onSave});

  @override
  _TaskFormDialogState createState() => _TaskFormDialogState();
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _priority;
  String _timeWorking = '';
  String _note = '';

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _startDate = DateFormat('yyyy-MM-dd').parse(widget.task!.startDate);
      _endDate = DateFormat('yyyy-MM-dd').parse(widget.task!.endDate);
      _priority = widget.task!.priority;
      _timeWorking = widget.task!.timeWorking;
      _note = widget.task!.note;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Add Task' : 'Update Task'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    suffixIcon:
                        Icon(Icons.calendar_today, color: Colors.deepPurple),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    ),
                  ),
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
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    suffixIcon:
                        Icon(Icons.calendar_today, color: Colors.deepPurple),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    ),
                  ),
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
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: DropdownButtonFormField(
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
                  decoration: InputDecoration(
                    labelText: 'Priority',
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Time Working',
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    ),
                  ),
                  onChanged: (value) {
                    _timeWorking = value;
                  },
                  initialValue: _timeWorking,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Note',
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    ),
                  ),
                  onChanged: (value) {
                    _note = value;
                  },
                  initialValue: _note,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              var task = Task(
                title: _titleController.text,
                startDate: DateFormat('yyyy-MM-dd').format(_startDate!),
                endDate: DateFormat('yyyy-MM-dd').format(_endDate!),
                priority: _priority!,
                isDone: widget.task?.isDone ?? false,
                timeWorking: _timeWorking,
                duration:
                    (_endDate!.difference(_startDate!).inDays).toString() +
                        ' days',
                note: _note,
              );
              if (widget.task == null) {
                await Provider.of<TaskProvider>(context, listen: false)
                    .addTask(task);
              } else {
                widget.task!.title = task.title;
                widget.task!.startDate = task.startDate;
                widget.task!.endDate = task.endDate;
                widget.task!.priority = task.priority;
                widget.task!.timeWorking = task.timeWorking;
                widget.task!.duration = task.duration;
                widget.task!.note = task.note;
                await Provider.of<TaskProvider>(context, listen: false)
                    .updateTask(widget.task!);
              }
              widget.onSave();
              Navigator.of(context).pop();
            }
          },
          child: Text(widget.task == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
