import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/widget/newButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class changePasswordScreen extends StatefulWidget {
  String compId;
  String username;
  String? target;
  changePasswordScreen(
      {super.key,
      required this.compId,
      required this.username,
      required this.target});

  @override
  State<changePasswordScreen> createState() => _changePasswordScreenState();
}

class _changePasswordScreenState extends State<changePasswordScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Users? currentUser = usersBox.get(widget.username.toString());
    Companies? currentCompany = companiesBox.get(widget.compId.toString());
    if (widget.target == "company") {
      return changeCompanyPassword(context, currentCompany);
    } else if (widget.target == "user") {
      return changeUserPassword(context, currentUser);
    } else {
      return Scaffold(
        body: Text("Problem var"),
      );
    }
  }

  Scaffold changeUserPassword(BuildContext context, Users? currentUser) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Your Password",
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(0, 0, 255, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            cPForms(
              controller: currentPasswordController,
              title: "Current Password",
              maxlines: 1,
              hint: "Enter current password",
            ),
            SizedBox(
              height: 15,
            ),
            cPForms(
              controller: newPasswordController,
              title: "New Password",
              maxlines: 1,
              hint: "Enter new password",
            ),
            SizedBox(
              height: 15,
            ),
            cPForms(
              controller: newPasswordController2,
              title: "Confirm Password",
              maxlines: 1,
              hint: "Enter new password again",
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 255, 1),
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: newButton(
                    ontap: () {
                      if (currentPasswordController.text == "" ||
                          newPasswordController.text == "" ||
                          newPasswordController2.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 255, 0.65),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Please fill all the blanks!",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            )));
                      } else {
                        if (currentPasswordController.text ==
                            currentUser?.usPassword.toString()) {
                          if (newPasswordController.text ==
                              newPasswordController2.text) {
                            usersBox.put(
                                currentUser?.usUserName.toString(),
                                Users(
                                    usUserName:
                                        currentUser!.usUserName.toString(),
                                    usPassword: newPasswordController.text,
                                    usName: currentUser.usName.toString(),
                                    usLastName:
                                        currentUser.usLastName.toString(),
                                    compID: currentUser.compID.toString(),
                                    isAdmin: currentUser.isAdmin));

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 255, 0.65),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Password changed successfully!",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                )));

                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 255, 0.65),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Password not confirmed!",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                )));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              content: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 255, 0.65),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "You entered the current password incorrectly",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              )));
                        }
                      }
                    },
                    title: "Change Password"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Scaffold changeCompanyPassword(
      BuildContext context, Companies? currentCompany) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Company Password",
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(0, 0, 255, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            cPForms(
              controller: currentPasswordController,
              title: "Current Password",
              maxlines: 1,
              hint: "Enter current password",
            ),
            SizedBox(
              height: 15,
            ),
            cPForms(
              controller: newPasswordController,
              title: "New Password",
              maxlines: 1,
              hint: "Enter new password",
            ),
            SizedBox(
              height: 15,
            ),
            cPForms(
              controller: newPasswordController2,
              title: "New Password",
              maxlines: 1,
              hint: "Enter new password again",
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 255, 1),
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: newButton(
                    ontap: () {
                      if (currentPasswordController.text == "" ||
                          newPasswordController.text == "" ||
                          newPasswordController2.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 255, 0.65),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Please fill all the blanks",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            )));
                      } else {
                        if (currentPasswordController.text ==
                            currentCompany?.companyPassword.toString()) {
                          if (newPasswordController.text ==
                              newPasswordController2.text) {
                            companiesBox.put(
                                currentCompany?.companyId.toString(),
                                Companies(
                                    companyName:
                                        currentCompany!.companyName.toString(),
                                    companyId: currentCompany.companyId,
                                    companyPassword:
                                        newPasswordController.text));

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 255, 0.65),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Password changed successfully",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                )));

                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 255, 0.65),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Passwords doesn't match",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                )));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              content: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 255, 0.65),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "You entered the current password incorrectly",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              )));
                        }
                      }
                    },
                    title: "Change Password"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class cPForms extends StatelessWidget {
  const cPForms({
    super.key,
    required this.controller,
    required this.title,
    required this.maxlines,
    required this.hint,
  });

  final String title;
  final TextEditingController controller;
  final String hint;
  final int maxlines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color.fromRGBO(0, 0, 255, 1))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              minLines: 1,
              maxLines: maxlines,
              controller: controller,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: hint),
            ),
          ),
        ),
      ],
    );
  }
}
