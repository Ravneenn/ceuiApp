import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Tasks.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/createTaskScreen.dart';
import 'package:ceui_app/widget/responsive.dart';
import 'package:ceui_app/widget/taskViewTablet.dart';
import 'package:ceui_app/widget/taskWidget.dart';
import 'package:ceui_app/widget/taskWidgetTablet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class tasksScreen extends StatefulWidget {
  tasksScreen(
      {super.key,
      required this.compBox,
      required this.compId,
      required this.compUsers,
      required this.username});
  String compId;
  String username;
  Box<Companies> compBox;
  Box<Users> compUsers;

  @override
  State<tasksScreen> createState() => _tasksScreenState();
}

class _tasksScreenState extends State<tasksScreen> {
  Tasks? chosenTaskTablet = null;
  Tasks? chosenTaskTabletManager = null;
  ValueListenable<Box<Tasks>> listenToTasks() => tasksBox.listenable();
  Screen device = Screen.mobile;

  @override
  Widget build(BuildContext context) {
    setState(() {
      device = detectScreen(MediaQuery.of(context).size);
    });

    Users? currentUser = widget.compUsers.get(widget.username.toString());
    if (currentUser?.isAdmin == true) {
      return tasksScreenManager(currentUser);
    } else if (currentUser?.isAdmin == false) {
      return tasksScreenNotManager(currentUser);
    } else {
      return Scaffold(
        body: Text("Bir Problem var"),
      );
    }
  }

  ValueListenableBuilder<Box<Tasks>> tasksScreenManager(Users? currtentUser) {
    return ValueListenableBuilder(
        valueListenable: listenToTasks(),
        builder: (ctx, Box<Tasks> box, Widget? child) {
          var tasks = [];
          for (var i = 0; i < box.length; i++) {
            if (box.getAt(i)?.compId == widget.compId.toString()) {
              tasks.add(box.getAt(i));
            }
          }
          tasks.sort(
            (a, b) {
              String deadlineA = a.deadline.toString();
              String deadlineB = b.deadline.toString();
              return deadlineA.compareTo(deadlineB);
            },
          );

          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "Tasks",
                  style: GoogleFonts.montserrat(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Color.fromRGBO(0, 0, 255, 1),
              ),
              floatingActionButton: fab(
                  compsId: widget.compId,
                  compsBox: widget.compBox,
                  compsUsers: widget.compUsers,
                  usersname: widget.username),
              body: device == Screen.mobile
                  ? tasks.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: tasks.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var task = tasks[index];
                            return TaskWidget(
                              isAdmin: usersBox
                                  .get(currtentUser?.usUserName.toString())!
                                  .isAdmin,
                              task: task,
                            );
                          },
                        )
                      : Center(
                          child: Text(
                          "No appointed task to show",
                          style: GoogleFonts.montserrat(fontSize: 20),
                        ))
                  : Row(
                      children: [
                        tasks.isNotEmpty
                            ? SizedBox(
                                width: 400,
                                height: double.infinity,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: tasks.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var task = tasks[index];
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          chosenTaskTabletManager = task;
                                        });
                                      },
                                      child: TaskWidgetTablet(
                                        isAdmin: usersBox
                                            .get(currtentUser?.usUserName
                                                .toString())!
                                            .isAdmin,
                                        task: task,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Text(
                                "No appointed task to show",
                                style: GoogleFonts.montserrat(fontSize: 20),
                              )),
                        taskViewTablet(
                          task: chosenTaskTabletManager,
                        )
                      ],
                    ));
        });
  }

  ValueListenableBuilder<Box<Tasks>> tasksScreenNotManager(
      Users? currtentUser) {
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
          tasks.sort(
            (a, b) {
              String deadlineA = a.deadline.toString();
              String deadlineB = b.deadline.toString();
              return deadlineA.compareTo(deadlineB);
            },
          );

          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "Tasks",
                  style: GoogleFonts.montserrat(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Color.fromRGBO(0, 0, 255, 1),
              ),
              body: device == Screen.mobile
                  ? tasks.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: tasks.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var task = tasks[index];
                            return TaskWidget(
                              isAdmin: usersBox
                                  .get(currtentUser?.usUserName.toString())!
                                  .isAdmin,
                              task: task,
                            );
                          },
                        )
                      : Center(
                          child: Text(
                          "You don't have any tasks to",
                          style: GoogleFonts.montserrat(fontSize: 20),
                        ))
                  : Row(
                      children: [
                        tasks.isNotEmpty
                            ? SizedBox(
                                width: 400,
                                height: double.infinity,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: tasks.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var task = tasks[index];
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          chosenTaskTablet = task;
                                        });
                                      },
                                      child: TaskWidgetTablet(
                                        isAdmin: usersBox
                                            .get(currtentUser?.usUserName
                                                .toString())!
                                            .isAdmin,
                                        task: task,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Text(
                                "You don't have any tasks to",
                                style: GoogleFonts.montserrat(fontSize: 20),
                              )),
                        taskViewTablet(
                          task: chosenTaskTablet,
                        )
                      ],
                    ));
        });
  }
}

// ignore: must_be_immutable
class fab extends StatelessWidget {
  String compsId;
  String usersname;
  Box<Companies> compsBox;
  Box<Users> compsUsers;
  fab({
    required this.compsId,
    required this.usersname,
    required this.compsBox,
    required this.compsUsers,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => createTaskScreeen(
                  compId: compsId,
                  compUsers: compsUsers,
                  compBox: compsBox,
                  username: usersname,
                )));
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 20,
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 255, 1),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Create a new Task",
              style: GoogleFonts.montserrat(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
