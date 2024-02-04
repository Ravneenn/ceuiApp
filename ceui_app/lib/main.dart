import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Reports.dart';
import 'package:ceui_app/Tasks.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/screens/compLoginScreen.dart';
import 'package:ceui_app/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'boxes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CompaniesAdapter());
  Hive.registerAdapter(UsersAdapter());
  Hive.registerAdapter(TasksAdapter());
  Hive.registerAdapter(ReportsAdapter());
  companiesBox = await Hive.openBox('compnaiesBox');
  usersBox = await Hive.openBox('usersBox');
  tasksBox = await Hive.openBox('tasksBox');
  reportsBox = await Hive.openBox('reportsBox');
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var finalCompID = prefs.getString("compId");
  var finalUsername = prefs.getString("username");
  runApp(ceuiApp(
    finalCompID: finalCompID,
    finalUsername: finalUsername,
  ));
}

class ceuiApp extends StatelessWidget {
  final String? finalCompID;
  final String? finalUsername;
  const ceuiApp(
      {super.key, required this.finalCompID, required this.finalUsername});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CEUI',
        home: (finalCompID == null && finalUsername == null)
            ? compLogin()
            : home(
                compBox: companiesBox,
                compUsers: usersBox,
                compId: finalCompID.toString(),
                username: finalUsername.toString()));
  }
}
