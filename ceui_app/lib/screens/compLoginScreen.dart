import 'package:ceui_app/Companies.dart';

import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/compSetupPhase1.dart';
import 'package:ceui_app/screens/userLoginScreen.dart';
import 'package:ceui_app/widget/newButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class compLogin extends StatefulWidget {
  const compLogin({super.key});

  @override
  State<compLogin> createState() => _compLoginState();
}

class _compLoginState extends State<compLogin> {
  TextEditingController loginCompId = TextEditingController();
  TextEditingController loginCompPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              Column(
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
                            controller: loginCompId,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type your company's id here..."),
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
                              controller: loginCompPassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      "Type your company's password here...")),
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  newButton(
                      ontap: () async {
                        if (companiesBox.containsKey(loginCompId.text)) {
                          Companies? loginAttempt =
                              companiesBox.get(loginCompId.text);
                          if (loginCompPassword.text !=
                              loginAttempt?.companyPassword) {
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
                                      "Invalid Company ID or Password",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                )));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => userLogin(
                                      compBox: companiesBox,
                                      compUsers: usersBox,
                                      loginAttempt: loginAttempt,
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
                                    "Invalid Company ID or Password",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              )));
                        }

                        //Navigator.pushNamed(context, "/login");
                      },
                      title: "Continue"),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              InkWell(
                onTap: () async {
                  print(" Burda da No problem with boxes");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => compSetup1(
                            compBox: companiesBox,
                            compUsers: usersBox,
                          )));
                },
                child: RichText(
                    text: TextSpan(
                        text: "Tap",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w900,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 15),
                        children: [
                      TextSpan(
                          text:
                              " to confirm your license and setup your company",
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 15))
                    ])),
              )
            ],
          ),
        )),
      )),
    );
  }
}
