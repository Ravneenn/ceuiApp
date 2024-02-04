import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'Tasks.g.dart';

@HiveType(typeId: 3)
class Tasks {
  Tasks(
      {required this.taskName,
      required this.appointer,
      required this.apoointed,
      required this.task,
      required this.deadline,
      required this.compId});

  @HiveField(0)
  String taskName;

  @HiveField(1)
  String appointer;

  @HiveField(2)
  String apoointed;

  @HiveField(3)
  String task;

  @HiveField(4)
  String deadline;

  @HiveField(5)
  String compId;
}
