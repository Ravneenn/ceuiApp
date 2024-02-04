import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/addPersonalScreen.dart';
import 'package:ceui_app/widget/responsive.dart';
import 'package:ceui_app/widget/staffViewTablet1.dart';
import 'package:ceui_app/widget/staffWidget.dart';
import 'package:ceui_app/widget/staffWidgetTablet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class personalsScreen extends StatefulWidget {
  String compId;
  String username;
  Box<Companies> compBox;
  Box<Users> compUsers;
  personalsScreen(
      {super.key,
      required this.compBox,
      required this.compUsers,
      required this.compId,
      required this.username});

  @override
  State<personalsScreen> createState() => _personalsScreenState();
}

class _personalsScreenState extends State<personalsScreen> {
  Users? chosenUserTablet = null;
  Screen device = Screen.mobile;
  ValueListenable<Box<Users>> listenToUsers() => usersBox.listenable();
  @override
  Widget build(BuildContext context) {
    setState(() {
      device = detectScreen(MediaQuery.of(context).size);
    });

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
          users.sort(
            (a, b) {
              String deadlineA = a.usName.toString();
              String deadlineB = b.usName.toString();
              return deadlineA.compareTo(deadlineB);
            },
          );

          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "Staffs",
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
                  ? users.isNotEmpty
                      ? ListView.builder(
                          itemCount: users.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var user = users[index];
                            return StaffWidget(
                              user: user,
                            );
                          },
                        )
                      : Center(
                          child: Text(
                          "No saved staff to show",
                          style: GoogleFonts.montserrat(fontSize: 20),
                        ))
                  : Row(
                      children: [
                        users.isNotEmpty
                            ? SizedBox(
                                width: 400,
                                height: double.infinity,
                                child: ListView.builder(
                                  itemCount: users.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var user = users[index];

                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          chosenUserTablet = user;
                                        });
                                      },
                                      child: StaffWidgetTablet(
                                        user: user,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Text(
                                "No saved staff to show",
                                style: GoogleFonts.montserrat(fontSize: 20),
                              )),
                        StaffViewTablet1(
                          user: chosenUserTablet,
                        ),
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
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => addPersonalScreen(
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
              "Add a new Staff",
              style: GoogleFonts.montserrat(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
