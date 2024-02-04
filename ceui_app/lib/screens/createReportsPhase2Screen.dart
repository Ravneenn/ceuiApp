import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Reports.dart';
import 'package:ceui_app/Tasks.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/reportsScreen.dart';
import 'package:ceui_app/widget/newButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class createReportsScreen2 extends StatefulWidget {
  createReportsScreen2(
      {super.key,
      required this.task,
      required this.compId,
      required this.username,
      required this.compBox,
      required this.compUsers});
  String? task;
  String compId;
  String username;
  Box<Companies> compBox;
  Box<Users> compUsers;

  @override
  State<createReportsScreen2> createState() => _createReportsScreen2State();
}

class _createReportsScreen2State extends State<createReportsScreen2> {
  TextEditingController reportNameController = TextEditingController();
  TextEditingController reportDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Tasks? currentTask = tasksBox.get(widget.task.toString());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Type details about the report",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 21),
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
                      "Task : ",
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.task.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.montserrat(
                                color: Color.fromRGBO(0, 0, 255, 1),
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TaskForms(
                  title: "Report Name",
                  controller: reportNameController,
                  hint: "Type the name of your report here...",
                  maxlines: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                TaskForms(
                    controller: reportDetailsController,
                    title: "Report",
                    maxlines: 20,
                    hint: "Write your report here..."),
                SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                  if (reportNameController.text == "") {
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
                                  } else if (reportDetailsController.text ==
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
                                    if (reportsBox.containsKey(
                                        reportNameController.text)) {
                                      reportNameController.clear();
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
                                                    "The Report Name you try to save is already using. Please try another one",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  ),
                                                ),
                                              )));
                                    } else {
                                      reportsBox.put(
                                          reportNameController.text,
                                          Reports(
                                              reportName:
                                                  reportNameController.text,
                                              writtenby:
                                                  widget.username.toString(),
                                              reciever: currentTask!.appointer
                                                  .toString(),
                                              report:
                                                  reportDetailsController.text,
                                              date: DateTime.now()
                                                  .toString()
                                                  .split(" ")[0],
                                              task: currentTask.taskName
                                                  .toString(),
                                              compId:
                                                  widget.compId.toString()));
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  reportsScreen(
                                                      compBox: widget.compBox,
                                                      compId: widget.compId,
                                                      compUsers:
                                                          widget.compUsers,
                                                      username:
                                                          widget.username)));
                                    }
                                  }
                                },
                                title: "Send Report"),
                          ),
                        ),
                      ],
                    )
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
