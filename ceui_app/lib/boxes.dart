import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Reports.dart';
import 'package:ceui_app/Tasks.dart';
import 'package:ceui_app/Users.dart';
import 'package:hive/hive.dart';

Box<Companies> companiesBox = Hive.box<Companies>('companiesBox');

Box<Users> usersBox = Hive.box<Users>('usersBox');

Box<Tasks> tasksBox = Hive.box<Tasks>('tasksBox');

Box<Reports> reportsBox = Hive.box<Reports>('reportsBox');
