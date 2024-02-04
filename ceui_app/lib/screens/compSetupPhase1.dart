import 'package:ceui_app/Companies.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/compSetupPhase2.dart';
import 'package:ceui_app/widget/newButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class compSetup1 extends StatefulWidget {
  Box<Companies> compBox;
  Box<Users> compUsers;
  compSetup1({super.key, required this.compBox, required this.compUsers});

  @override
  State<compSetup1> createState() => _compSetup1State();
}

class _compSetup1State extends State<compSetup1> {
  TextEditingController compName = TextEditingController();
  TextEditingController compId = TextEditingController();
  TextEditingController compPassword = TextEditingController();

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
                              title: "Setting company's information form",
                              description:
                                  "this form is also contains company's acces informations"),
                          SizedBox(
                            height: 15,
                          ),
                          setupFormsDouble(
                              name: "Company Name",
                              hint: "Type your company name...",
                              control: compName),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setupForms(
                                name: "Company id",
                                hint: "Type a Company id...",
                                control: compId,
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Company Password",
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
                                                  controller: compPassword,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          "Type a company password"),
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
                            height: 30,
                          ),
                          newButton(
                            ontap: () async {
                              await Hive.initFlutter();
                              companiesBox = widget.compBox;

                              if (companiesBox.containsKey(compId.text)) {
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
                                              "The Company ID is already exist, please try another one",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        )));
                              } else {
                                companiesBox.put(
                                    "${compId.text}",
                                    Companies(
                                      companyName: compName.text,
                                      companyId: compId.text,
                                      companyPassword: compPassword.text,
                                    ));
                                setState(() {});

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => compSetup2(
                                          compID: "${compId.text}",
                                          compUsers: widget.compUsers,
                                        )));
                              }
                            },
                            title: "Contuine",
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
