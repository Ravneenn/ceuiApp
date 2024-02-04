import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/screens/createTaskPhase2Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class StaffWidgetForTasks extends StatelessWidget {
  final Users? user;
  String compId;
  String username;
  Box<Companies> compBox;
  Box<Users> compUsers;
  StaffWidgetForTasks({
    super.key,
    required this.user,
    required this.compId,
    required this.username,
    required this.compBox,
    required this.compUsers,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => createTaskScreen2(
                  appointed: user?.usUserName.toString(),
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
                  text: user?.usName.toString(),
                  style:
                      GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
                  children: [
                TextSpan(
                  text: " ${user?.usLastName.toString()}",
                )
              ])),
          subtitle: Text(
            user!.usUserName.toString(),
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
