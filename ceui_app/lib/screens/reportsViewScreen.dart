import 'package:ceui_app/Reports.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class reportsView extends StatefulWidget {
  reportsView({super.key, required this.report});
  Reports? report;

  @override
  State<reportsView> createState() => _reportsViewState();
}

class _reportsViewState extends State<reportsView> {
  @override
  Widget build(BuildContext context) {
    Users? writtenBy = usersBox.get(widget.report?.writtenby.toString());
    Users? reciever = usersBox.get(widget.report?.reciever.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.report!.reportName.toString(),
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
                                "${writtenBy!.usName} ${writtenBy.usLastName}",
                            style: GoogleFonts.montserrat(
                                color: Color.fromRGBO(0, 0, 255, 1),
                                fontSize: 19,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                            text: " write this report for ",
                            style: GoogleFonts.montserrat(color: Colors.black)),
                        TextSpan(
                          text: "${reciever!.usName} ${reciever.usLastName}",
                        ),
                        TextSpan(
                            text: " on task: ",
                            style: GoogleFonts.montserrat(color: Colors.black)),
                        TextSpan(
                            text: widget.report?.task.toString(),
                            style: GoogleFonts.montserrat(
                                color: Color.fromRGBO(0, 0, 255, 1),
                                fontSize: 19,
                                fontWeight: FontWeight.w600)),
                      ])),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    text: "Writed On: ",
                    style: GoogleFonts.montserrat(
                        color: Color.fromRGBO(0, 0, 255, 1),
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                          text: widget.report?.date.toString(),
                          style: GoogleFonts.montserrat(color: Colors.black))
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Report:",
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
                      text: widget.report?.report.toString(),
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
