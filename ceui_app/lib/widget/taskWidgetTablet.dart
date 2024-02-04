import 'package:ceui_app/Tasks.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskWidgetTablet extends StatelessWidget {
  final Tasks? task;
  final bool isAdmin;
  const TaskWidgetTablet(
      {super.key, required this.task, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    if (isAdmin == true) {
      return TaskWidgetTabletManager(context);
    } else if (isAdmin == false) {
      return TaskWidgetTabletNotManager(context);
    } else {
      return Scaffold(
        body: Text("Bir Problem var"),
      );
    }
  }

  AnimatedContainer TaskWidgetTabletManager(BuildContext context) {
    Users? appointer = usersBox.get(task!.appointer.toString());
    Users? appointed = usersBox.get(task!.apoointed.toString());
    return AnimatedContainer(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 255, 0.1),
          borderRadius: BorderRadius.circular(8)),
      duration: const Duration(milliseconds: 600),
      child: ListTile(
        trailing: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45, vertical: 15),
                          child: Text(
                            "Are you sure you want to delete this staff: ${task!.taskName.toString()} ?",
                            style: GoogleFonts.montserrat(fontSize: 30),
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color.fromRGBO(0, 0, 255, 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Cancel",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  tasksBox.delete(task?.taskName.toString());
                                  setState() {}
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color.fromRGBO(0, 0, 255, 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Remove",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ));
            },
            child: Icon(
              Icons.delete,
              size: 28,
            )),
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
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: "Appointer: ",
                      style: GoogleFonts.montserrat(
                          color: Color.fromRGBO(0, 0, 255, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                      children: [
                        TextSpan(
                          text: "${appointer?.usName} ${appointer?.usLastName}",
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
                          text: "${appointed?.usName} ${appointed?.usLastName}",
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
    );
  }

  AnimatedContainer TaskWidgetTabletNotManager(BuildContext context) {
    Users? appointer = usersBox.get(task!.appointer.toString());
    Users? appointed = usersBox.get(task!.apoointed.toString());

    return AnimatedContainer(
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
                          text: "${appointer?.usName} ${appointer?.usLastName}",
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
                          text: "${appointed?.usName} ${appointed?.usLastName}",
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
    );
  }
}
