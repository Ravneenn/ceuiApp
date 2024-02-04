import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Tasks.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/widget/taskWidgetForReports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class createReportScreeen extends StatefulWidget {
  String compId;
  String username;
  Box<Companies> compBox;
  Box<Users> compUsers;
  createReportScreeen(
      {super.key,
      required this.compBox,
      required this.compUsers,
      required this.compId,
      required this.username});

  @override
  State<createReportScreeen> createState() => createReportScreeenState();
}

class createReportScreeenState extends State<createReportScreeen> {
  ValueListenable<Box<Tasks>> listenToTasks() => tasksBox.listenable();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: listenToTasks(),
        builder: (ctx, Box<Tasks> box, Widget? child) {
          var tasks = [];
          for (var i = 0; i < box.length; i++) {
            if (box.getAt(i)?.apoointed == widget.username.toString() &&
                box.getAt(i)?.compId == widget.compId.toString()) {
              tasks.add(box.getAt(i));
            }
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Choose a task to write a report",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Color.fromRGBO(0, 0, 255, 1),
            ),
            body: tasks.isNotEmpty
                ? ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var task = tasks[index];
                      return TaskWidgetForReports(
                        task: task,
                        compId: widget.compId.toString(),
                        username: widget.username.toString(),
                        compBox: widget.compBox,
                        compUsers: widget.compUsers,
                      );
                    },
                  )
                : Center(
                    child: Text(
                    "No saved staff to show",
                    style: GoogleFonts.montserrat(fontSize: 20),
                  )),
          );
        });
  }
}
