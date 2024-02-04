import 'package:ceui_app/Reports.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/reportsViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportWidget extends StatelessWidget {
  final Reports? report;
  const ReportWidget({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    Users? writtenBy = usersBox.get(report!.writtenby.toString());
    Users? reciever = usersBox.get(report!.reciever.toString());

    return AnimatedContainer(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 255, 0.1),
          borderRadius: BorderRadius.circular(8)),
      duration: const Duration(milliseconds: 600),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => reportsView(report: report)));
        },
        trailing: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45, vertical: 15),
                          child: Text(
                            "Are you sure you want to delete this report: ${report?.reportName.toString()} ?",
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
                                  reportsBox
                                      .delete(report?.reportName.toString());
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
          text: report?.reportName.toString(),
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 30),
        )),
        subtitle: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: "Written By: ",
                      style: GoogleFonts.montserrat(
                          color: Color.fromRGBO(0, 0, 255, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                      children: [
                        TextSpan(
                          text:
                              "${writtenBy?.usName.toString()} ${writtenBy?.usLastName.toString()}",
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                      ]),
                ),
                RichText(
                  text: TextSpan(
                      text: "Reciever: ",
                      style: GoogleFonts.montserrat(
                          color: Color.fromRGBO(0, 0, 255, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                      children: [
                        TextSpan(
                          text:
                              "${reciever?.usName.toString()} ${reciever?.usLastName.toString()}",
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                      ]),
                ),
                RichText(
                  text: TextSpan(
                      text: "Writing Date: ",
                      style: GoogleFonts.montserrat(
                          color: Color.fromRGBO(0, 0, 255, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                      children: [
                        TextSpan(
                          text: report!.date.toString(),
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
