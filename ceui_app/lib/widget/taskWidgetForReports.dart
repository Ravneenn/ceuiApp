import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Tasks.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/createReportsPhase2Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class TaskWidgetForReports extends StatelessWidget {
  final Tasks? task;
  String compId;
  String username;
  Box<Companies> compBox;
  Box<Users> compUsers;
  TaskWidgetForReports({
    super.key,
    required this.task,
    required this.compId,
    required this.username,
    required this.compBox,
    required this.compUsers,
  });

  @override
  Widget build(BuildContext context) {
    Users? appointer = usersBox.get(task!.appointer.toString());
    Users? appointed = usersBox.get(task!.apoointed.toString());
    return InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => createReportsScreen2(
                    task: task?.taskName.toString(),
                    compId: compId.toString(),
                    username: username.toString(),
                    compBox: compBox,
                    compUsers: compUsers,
                  )));
        },
        child: AnimatedContainer(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 255, 0.1),
              borderRadius: BorderRadius.circular(8)),
          duration: const Duration(milliseconds: 600),
          child: ListTile(
            title: RichText(
                text: TextSpan(
              text: task?.taskName.toString(),
              style: GoogleFonts.montserrat(color: Colors.black, fontSize: 30),
            )),
            subtitle: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Appointer: ",
                          style: GoogleFonts.montserrat(
                              color: Color.fromRGBO(0, 0, 255, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                          children: [
                            TextSpan(
                              text:
                                  "${appointer?.usName} ${appointer?.usLastName}",
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Appointed: ",
                          style: GoogleFonts.montserrat(
                              color: Color.fromRGBO(0, 0, 255, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                          children: [
                            TextSpan(
                              text:
                                  "${appointed?.usName} ${appointed?.usLastName}",
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Deadline: ",
                          style: GoogleFonts.montserrat(
                              color: Color.fromRGBO(0, 0, 255, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                          children: [
                            TextSpan(
                              text: task!.deadline.toString(),
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
