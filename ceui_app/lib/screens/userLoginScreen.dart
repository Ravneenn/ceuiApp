import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/homeScreen.dart';
import 'package:ceui_app/widget/keepLogged.dart';
import 'package:ceui_app/widget/newButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class userLogin extends StatefulWidget {
  Box<Companies> compBox;
  Box<Users> compUsers;
  Companies? loginAttempt;
  userLogin(
      {super.key,
      required this.compBox,
      required this.compUsers,
      required this.loginAttempt});

  @override
  State<userLogin> createState() => _userLoginState();
}

class _userLoginState extends State<userLogin> {
  TextEditingController loginUserName = TextEditingController();
  TextEditingController loginUserPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              shadowColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.white),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(5, 10, 220, 1),
                    Color.fromRGBO(5, 10, 220, 0.75)
                  ]),
                ),
              )),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(5, 10, 220, 1),
              Color.fromRGBO(5, 10, 220, 0.75)
            ])),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "assets/logo/text_logo.svg",
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: 400,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: TextField(
                            controller: loginUserName,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type your username here..."),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: 400,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: TextField(
                              controller: loginUserPassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type your user password here...")),
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  newButton(
                      ontap: () {
                        Companies? compLoginAttempt = widget.loginAttempt;
                        if (usersBox.containsKey(loginUserName.text)) {
                          Users? userLoginAttempt =
                              usersBox.get(loginUserName.text);
                          if (userLoginAttempt?.compID ==
                              compLoginAttempt?.companyId) {
                            if (userLoginAttempt?.usPassword ==
                                loginUserPassword.text) {
                              writeStorage(compLoginAttempt!.companyId,
                                  loginUserName.text);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => home(
                                        compBox: companiesBox,
                                        compUsers: usersBox,
                                        username: loginUserName.text,
                                        compId: compLoginAttempt.companyId,
                                      )));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      content: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.65),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(
                                            "Invalid username or Password",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w700),
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
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.65),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      "Invalid username or Password",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w700),
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
                                    color: Color.fromRGBO(255, 255, 255, 0.65),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    "Invalid username or Password",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              )));
                        }
                      },
                      title: "Login")
                ],
              ),
            )),
          )),
    );
  }
}
