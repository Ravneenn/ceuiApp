import 'package:ceui_app/Tasks.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class tasksView extends StatefulWidget {
  tasksView({super.key, required this.task});
  Tasks? task;

  @override
  State<tasksView> createState() => _tasksViewState();
}

class _tasksViewState extends State<tasksView> {
  @override
  Widget build(BuildContext context) {
    Users? appointed = usersBox.get(widget.task?.apoointed.toString());
    Users? appointer = usersBox.get(widget.task?.appointer.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task!.taskName.toString(),
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w700),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(0, 0, 255, 1),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
              child: RichText(
                  selectionColor: Color.fromRGBO(0, 0, 255, 1),
                  textAlign: TextAlign.right,
                  text: TextSpan(
                      style: GoogleFonts.montserrat(
                          color: Color.fromRGBO(0, 0, 255, 1),
                          fontSize: 19,
                          fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                            text:
                                "${appointed!.usName} ${appointed.usLastName}",
                            style: GoogleFonts.montserrat(
                                color: Color.fromRGBO(0, 0, 255, 1),
                                fontSize: 19,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                            text: " appointed by ",
                            style: GoogleFonts.montserrat(color: Colors.black)),
                        TextSpan(
                          text: "${appointer!.usName} ${appointer.usLastName}",
                        ),
                        TextSpan(
                            text: " to complete this task.",
                            style: GoogleFonts.montserrat(color: Colors.black)),
                      ])),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    text: "Deadline: ",
                    style: GoogleFonts.montserrat(
                        color: Color.fromRGBO(0, 0, 255, 1),
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                          text: widget.task?.deadline.toString(),
                          style: GoogleFonts.montserrat(color: Colors.black))
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Description:",
                  style: GoogleFonts.montserrat(
                      color: Color.fromRGBO(0, 0, 255, 1),
                      fontSize: 25,
                      fontWeight: FontWeight.w600)),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 255, 0.1),
                  borderRadius: BorderRadius.circular(11)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
                child: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      text: widget.task?.task.toString(),
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
