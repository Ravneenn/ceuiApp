import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/widget/staffWidgetForTasks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class createTaskScreeen extends StatefulWidget {
  String compId;
  String username;
  Box<Companies> compBox;
  Box<Users> compUsers;
  createTaskScreeen(
      {super.key,
      required this.compBox,
      required this.compUsers,
      required this.compId,
      required this.username});

  @override
  State<createTaskScreeen> createState() => createTaskScreeenState();
}

class createTaskScreeenState extends State<createTaskScreeen> {
  ValueListenable<Box<Users>> listenToUsers() => usersBox.listenable();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: listenToUsers(),
        builder: (ctx, Box<Users> box, Widget? child) {
          var users = [];
          for (var i = 0; i < box.length; i++) {
            if (box.getAt(i)?.compID == widget.compId.toString() &&
                box.getAt(i)?.usUserName != widget.username.toString()) {
              users.add(box.getAt(i));
            }
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Choose a staff to give a task",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Color.fromRGBO(0, 0, 255, 1),
            ),
            body: users.isNotEmpty
                ? ListView.builder(
                    itemCount: users.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var user = users[index];
                      return StaffWidgetForTasks(
                        user: user,
                        compId: widget.compId.toString(),
                        username: widget.username.toString(),
                        compBox: widget.compBox,
                        compUsers: widget.compUsers,
                      );
                    },
                  )
                : Center(
                    child: Text(
                    "No saved staff to show",
                    style: GoogleFonts.montserrat(fontSize: 20),
                  )),
          );
        });
  }
}
