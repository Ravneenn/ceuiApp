import 'package:ceui_app/Reports.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/reportsViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportWidgetForHomeScreen extends StatelessWidget {
  final Reports? report;
  const ReportWidgetForHomeScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Users? writtenBy = usersBox.get(report!.writtenby.toString());
    // ignore: unused_local_variable
    Users? reciever = usersBox.get(report!.reciever.toString());

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Expanded(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => reportsView(report: report)));
          },
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      report!.reportName,
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Row(
                      children: [
                        Text(
                          "From: ",
                          style: GoogleFonts.montserrat(
                              color: Color.fromRGBO(0, 0, 255, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Text(
                          "${writtenBy?.usName} ${writtenBy?.usLastName}",
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReportWidgetForHomeScreenTablet extends StatelessWidget {
  final Reports? report;
  const ReportWidgetForHomeScreenTablet({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Users? writtenBy = usersBox.get(report!.writtenby.toString());
    // ignore: unused_local_variable
    Users? reciever = usersBox.get(report!.reciever.toString());

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Expanded(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => reportsView(report: report)));
          },
          child: Container(
            width: (MediaQuery.of(context).size.width * (16.45 / 100)),
            height: 50,
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 255, 1),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width * (16.4 / 100)),
                      child: Text(
                        report!.reportName,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Text(
                      "From: ",
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width * (16.4 / 100)),
                      child: Text(
                        "${writtenBy?.usName} ${writtenBy?.usLastName}",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
