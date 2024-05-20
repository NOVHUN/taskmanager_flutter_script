import 'package:hive/hive.dart';

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
}
