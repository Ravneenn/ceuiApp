import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Tasks.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/tasksScreen.dart';
import 'package:ceui_app/widget/newButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class createTaskScreen2 extends StatefulWidget {
  createTaskScreen2(
      {super.key,
      required this.appointed,
      required this.compId,
      required this.username,
      required this.compBox,
      required this.compUsers});
  String? appointed;
  String compId;
  String username;
  Box<Companies> compBox;
  Box<Users> compUsers;

  @override
  State<createTaskScreen2> createState() => _createTaskScreen2State();
}

class _createTaskScreen2State extends State<createTaskScreen2> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDetailsController = TextEditingController();
  TextEditingController taskDeadlineController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (_picked != null) {
      setState(() {
        taskDeadlineController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Type details about the task",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.w700),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color.fromRGBO(0, 0, 255, 1),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Appointed Staff: ",
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    Text(
                      widget.appointed.toString(),
                      style: GoogleFonts.montserrat(
                          color: Color.fromRGBO(0, 0, 255, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TaskForms(
                  title: "Task Name",
                  controller: taskNameController,
                  hint: "Type the name of your task here...",
                  maxlines: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                TaskForms(
                    controller: taskDetailsController,
                    title: "Task Details",
                    maxlines: 20,
                    hint: "Express your task here..."),
                SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deadline",
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Color.fromRGBO(0, 0, 255, 1))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: taskDeadlineController,
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(0, 0, 255, 1)),
                            border: InputBorder.none,
                            labelText: "Date",
                          ),
                          readOnly: true,
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 255, 1),
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: newButton(
                                ontap: () {
                                  if (taskNameController.text == "") {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                            content: Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      0, 0, 255, 0.65),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Center(
                                                child: Text(
                                                  "Please fill all the blanks!",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            )));
                                  } else if (taskDetailsController.text == "") {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                            content: Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      0, 0, 255, 0.65),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Center(
                                                child: Text(
                                                  "Please fill all the blanks!",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            )));
                                  } else if (taskDeadlineController.text ==
                                      "") {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                            content: Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      0, 0, 255, 0.65),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Center(
                                                child: Text(
                                                  "Please fill all the blanks!",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            )));
                                  } else {
                                    if (tasksBox
                                        .containsKey(taskNameController.text)) {
                                      taskNameController.clear();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                              content: Container(
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        0, 0, 255, 0.65),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Center(
                                                  child: Text(
                                                    "The Task Name you try to save is already using. Please try another one",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  ),
                                                ),
                                              )));
                                    } else {
                                      tasksBox.put(
                                          "${taskNameController.text}",
                                          Tasks(
                                              taskName: taskNameController.text,
                                              appointer:
                                                  widget.username.toString(),
                                              apoointed:
                                                  widget.appointed.toString(),
                                              task: taskDetailsController.text,
                                              deadline:
                                                  taskDeadlineController.text,
                                              compId:
                                                  widget.compId.toString()));
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => tasksScreen(
                                                  compBox: widget.compBox,
                                                  compId: widget.compId,
                                                  compUsers: widget.compUsers,
                                                  username: widget.username)));
                                    }
                                  }
                                },
                                title: "Appoint"),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskForms extends StatelessWidget {
  const TaskForms({
    super.key,
    required this.controller,
    required this.title,
    required this.maxlines,
    required this.hint,
  });

  final String title;
  final TextEditingController controller;
  final String hint;
  final int maxlines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color.fromRGBO(0, 0, 255, 1))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              minLines: 1,
              maxLines: maxlines,
              controller: controller,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: hint),
            ),
          ),
        ),
      ],
    );
  }
}
