import 'package:ceui_app/Reports.dart';
import 'package:ceui_app/Tasks.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/staffViewScreen.dart';
import 'package:ceui_app/widget/newButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class StaffViewTablet1 extends StatefulWidget {
  Users? user;
  StaffViewTablet1({required this.user, super.key});

  @override
  State<StaffViewTablet1> createState() => _StaffViewTablet1State();
}

class _StaffViewTablet1State extends State<StaffViewTablet1> {
  ValueListenable<Box<Tasks>> listenToTasks() => tasksBox.listenable();
  ValueListenable<Box<Reports>> listenToReports() => reportsBox.listenable();
  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      return Expanded(
          child: Container(
              width: 400,
              height: double.infinity,
              child: Center(
                  child: Text(
                "Please select a user to view",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ))));
    } else {
      Users? currentUser = widget.user;

      return Expanded(
        child: Container(
          width: 400,
          height: double.infinity,
          child: Column(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(0, 0, 255, 1),
                          Color.fromRGBO(0, 93, 255, 1)
                        ]),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35))),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://upload.wikimedia.org/wikipedia/commons/f/f4/Nelson_Neves_picuture.gif?20151130113858"),
                                    radius: 50),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${currentUser?.usName.toString()} ${currentUser?.usLastName.toString()}",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              Text(
                                "${currentUser?.usUserName.toString()}",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 255, 1),
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: newButton(
                            ontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => staffViewScreen(
                                      username:
                                          currentUser!.usUserName.toString(),
                                      compId: currentUser.compID.toString())));
                            },
                            title: "View Tasks and Reports"),
                      ))
                ],
              ),
            )
          ]),
        ),
      );
    }
  }
}
