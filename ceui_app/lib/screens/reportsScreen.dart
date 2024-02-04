import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Reports.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/createReportsScreen.dart';
import 'package:ceui_app/widget/reportWidget.dart';
import 'package:ceui_app/widget/reportWidgetTablet.dart';
import 'package:ceui_app/widget/reportsViewTablet.dart';
import 'package:ceui_app/widget/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class reportsScreen extends StatefulWidget {
  reportsScreen(
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
  State<reportsScreen> createState() => _reportsScreenState();
}

class _reportsScreenState extends State<reportsScreen> {
  Reports? chosenReportTablet = null;
  Reports? chosenReportTabletManager = null;
  ValueListenable<Box<Reports>> listenToReports() => reportsBox.listenable();
  Screen device = Screen.mobile;

  @override
  Widget build(BuildContext context) {
    setState(() {
      device = detectScreen(MediaQuery.of(context).size);
    });
    Users? currentUser = widget.compUsers.get(widget.username.toString());
    if (currentUser?.isAdmin == true) {
      return reportsScreenManager();
    } else if (currentUser?.isAdmin == false) {
      return reportsScreenNotManager();
    } else {
      return Scaffold(
        body: Text("Bir Problem var"),
      );
    }
  }

  ValueListenableBuilder<Box<Reports>> reportsScreenManager() {
    return ValueListenableBuilder(
        valueListenable: listenToReports(),
        builder: (ctx, Box<Reports> box, Widget? child) {
          var reports = [];
          for (var i = 0; i < box.length; i++) {
            if (box.getAt(i)?.compId == widget.compId.toString()) {
              reports.add(box.getAt(i));
            }
          }
          reports.sort(
            (a, b) {
              String dateA = a.date.toString();
              String dateB = b.date.toString();
              return dateB.compareTo(dateA);
            },
          );

          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "Reports",
                  style: GoogleFonts.montserrat(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Color.fromRGBO(0, 0, 255, 1),
              ),
              body: device == Screen.mobile
                  ? reports.isNotEmpty
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
                          "No recieved reports to show",
                          style: GoogleFonts.montserrat(fontSize: 20),
                        ))
                  : Row(
                      children: [
                        reports.isNotEmpty
                            ? SizedBox(
                                width: 400,
                                height: double.infinity,
                                child: ListView.builder(
                                  itemCount: reports.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var report = reports[index];
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          chosenReportTabletManager = report;
                                        });
                                      },
                                      child: ReportWidgetTablet(
                                        report: report,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Text(
                                "No recieved reports to show",
                                style: GoogleFonts.montserrat(fontSize: 20),
                              )),
                        reportsViewTablet(report: chosenReportTabletManager)
                      ],
                    ));
        });
  }

  ValueListenableBuilder<Box<Reports>> reportsScreenNotManager() {
    return ValueListenableBuilder(
        valueListenable: listenToReports(),
        builder: (ctx, Box<Reports> box, Widget? child) {
          var reports = [];
          for (var i = 0; i < box.length; i++) {
            if (box.getAt(i)?.writtenby == widget.username.toString() &&
                box.getAt(i)?.compId == widget.compId.toString()) {
              reports.add(box.getAt(i));
            }
          }
          reports.sort(
            (a, b) {
              String deadlineA = a.date.toString();
              String deadlineB = b.date.toString();
              return deadlineB.compareTo(deadlineA);
            },
          );

          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "Reports",
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
                  ? reports.isNotEmpty
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
                          "No writed reports to show",
                          style: GoogleFonts.montserrat(fontSize: 20),
                        ))
                  : Row(
                      children: [
                        reports.isNotEmpty
                            ? SizedBox(
                                width: 400,
                                height: double.infinity,
                                child: ListView.builder(
                                  itemCount: reports.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var report = reports[index];
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          chosenReportTablet = report;
                                        });
                                      },
                                      child: ReportWidgetTablet(
                                        report: report,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Text(
                                "No writed reports to show",
                                style: GoogleFonts.montserrat(fontSize: 20),
                              )),
                        reportsViewTablet(report: chosenReportTablet)
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
            builder: (context) => createReportScreeen(
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
              "Write a new Report",
              style: GoogleFonts.montserrat(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
