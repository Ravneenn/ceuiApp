import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'Reports.g.dart';

@HiveType(typeId: 4)
class Reports {
  Reports(
      {required this.reportName,
      required this.writtenby,
      required this.reciever,
      required this.report,
      required this.date,
      required this.task,
      required this.compId});

  @HiveField(0)
  String reportName;

  @HiveField(1)
  String writtenby;

  @HiveField(2)
  String reciever;

  @HiveField(3)
  String report;

  @HiveField(4)
  String date;

  @HiveField(5)
  String task;

  @HiveField(6)
  String compId;
}
