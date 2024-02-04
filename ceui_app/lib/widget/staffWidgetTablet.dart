import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffWidgetTablet extends StatelessWidget {
  final Users? user;
  const StaffWidgetTablet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
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
                            "Are you sure you want to delete this staff: ${user?.usUserName.toString()}?",
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
                                  usersBox.delete(user?.usUserName.toString());
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
            child: Icon(Icons.delete)),
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
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 15),
        ),
      ),
    );
  }
}
