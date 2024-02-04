import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/compLoginScreen.dart';
import 'package:ceui_app/widget/newButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class compSetup2 extends StatefulWidget {
  String compID;
  Box<Users> compUsers;

  compSetup2({super.key, required this.compID, required this.compUsers});

  @override
  State<compSetup2> createState() => _compSetup2State();
}

class _compSetup2State extends State<compSetup2> {
  TextEditingController userUserName = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController userLastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text(
              "Setup your company",
              style: GoogleFonts.montserrat(
                  color: Color.fromRGBO(0, 0, 255, 1),
                  fontWeight: FontWeight.w500),
            )),
            iconTheme: IconThemeData(color: Color.fromRGBO(0, 0, 255, 1)),
            backgroundColor: Colors.white,
          ),
          extendBodyBehindAppBar: true,
          body: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(5, 10, 220, 1),
                Color.fromRGBO(5, 10, 220, 0.75)
              ])),
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          setupFormsTitle(
                              title: "Setting CEO's information form",
                              description:
                                  "this form are also contains CEO's login informations"),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setupForms(
                                name: "Username",
                                hint: "Type your username...",
                                control: userUserName,
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("User Password",
                                          style: GoogleFonts.montserrat(
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Container(
                                            height: 45,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: TextField(
                                                  obscureText: true,
                                                  controller: userPassword,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Type your user password...",
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setupForms(
                                name: "Name",
                                hint: "Type your name...",
                                control: userName,
                              ),
                              setupForms(
                                name: "Surname",
                                hint: "Type your user surname...",
                                control: userLastName,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          newButton(
                            ontap: () async {
                              await Hive.initFlutter();
                              usersBox = widget.compUsers;

                              if (usersBox.containsKey(userUserName.text)) {
                                userUserName.clear();
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
                                              "The Username is already exist, please try another one",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        )));
                              } else {
                                usersBox.put(
                                    "${userUserName.text}",
                                    Users(
                                        usUserName: userUserName.text,
                                        usPassword: userPassword.text,
                                        usName: userName.text,
                                        usLastName: userLastName.text,
                                        compID: widget.compID.toString(),
                                        isAdmin: true));
                                setState(() {});

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => compLogin()));
                              }
                            },
                            title: "Complate Setup and login",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

class setupFormsTitle extends StatelessWidget {
  final String title;
  final String description;
  const setupFormsTitle({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20),
        ),
        Text(
          description,
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
        ),
      ],
    );
  }
}

class setupForms extends StatelessWidget {
  final String name;
  final String hint;
  final void Function(String)? funcs;
  final TextEditingController control;

  const setupForms({
    super.key,
    required this.name,
    required this.hint,
    this.funcs,
    required this.control,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 15,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: TextField(
                        controller: control,
                        onChanged: funcs,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: hint),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class setupFormsDouble extends StatelessWidget {
  final String name;
  final String hint;
  final void Function(String)? funcs;
  final TextEditingController control;

  const setupFormsDouble({
    super.key,
    required this.name,
    required this.hint,
    this.funcs,
    required this.control,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: GoogleFonts.montserrat(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 15,
                fontWeight: FontWeight.w700)),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: TextField(
                    controller: control,
                    onChanged: funcs,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: hint),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
