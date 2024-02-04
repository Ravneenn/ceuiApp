import 'package:ceui_app/Reports.dart';
import 'package:ceui_app/Tasks.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/widget/reportWidget.dart';
import 'package:ceui_app/widget/taskWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class staffViewScreen extends StatefulWidget {
  String username;
  String compId;
  staffViewScreen({required this.username, required this.compId, super.key});

  @override
  State<staffViewScreen> createState() => _staffViewScreenState();
}

class _staffViewScreenState extends State<staffViewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ValueListenable<Box<Tasks>> listenToTasks() => tasksBox.listenable();
  ValueListenable<Box<Reports>> listenToReports() => reportsBox.listenable();
  @override
  Widget build(BuildContext context) {
    Users? currentUser = usersBox.get(widget.username.toString());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "${currentUser?.usName} ${currentUser?.usLastName}",
              style: GoogleFonts.montserrat(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color.fromRGBO(0, 0, 255, 1),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Tasks",
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
                Tab(
                  child: Text(
                    "Reports",
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ValueListenableBuilder(
                  valueListenable: listenToTasks(),
                  builder: (ctx, Box<Tasks> box, Widget? child) {
                    var tasks = [];
                    for (var i = 0; i < box.length; i++) {
                      if (box.getAt(i)?.apoointed ==
                              widget.username.toString() &&
                          box.getAt(i)?.compId == widget.compId.toString()) {
                        tasks.add(box.getAt(i));
                      }
                    }

                    return Scaffold(
                      body: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: double.infinity,
                                  height: 723,
                                  child: tasks.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: tasks.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            var task = tasks[index];
                                            return TaskWidget(
                                              isAdmin: true,
                                              task: task,
                                            );
                                          },
                                        )
                                      : Center(
                                          child: Text(
                                          "${currentUser!.usName} ${currentUser.usLastName} has no tasks to show",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 20),
                                        ))),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              ValueListenableBuilder(
                  valueListenable: listenToReports(),
                  builder: (ctx, Box<Reports> box, Widget? child) {
                    var reports = [];
                    for (var i = 0; i < box.length; i++) {
                      if (box.getAt(i)?.writtenby ==
                              widget.username.toString() &&
                          box.getAt(i)?.compId == widget.compId.toString()) {
                        reports.add(box.getAt(i));
                      }
                    }

                    return Scaffold(
                      backgroundColor: Colors.white,
                      body: SizedBox(
                          width: double.infinity,
                          height: 723,
                          child: reports.isNotEmpty
                              ? ListView.builder(
                                  itemCount: reports.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var report = reports[index];
                                    return ReportWidget(
                                      report: report,
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                  "No reports from ${currentUser!.usName} ${currentUser.usLastName} to show",
                                  style: GoogleFonts.montserrat(fontSize: 20),
                                ))),
                    );
                  })
            ],
          )),
    );
  }
}
