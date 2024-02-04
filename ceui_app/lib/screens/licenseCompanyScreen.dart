import 'package:ceui_app/widget/newButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class licenseComp extends StatefulWidget {
  const licenseComp({super.key});

  @override
  State<licenseComp> createState() => _licenseCompState();
}

class _licenseCompState extends State<licenseComp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "After ",
                              style: GoogleFonts.montserrat(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 15),
                              children: [
                            TextSpan(
                                text: "confirm",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontSize: 15),
                                children: [
                                  TextSpan(
                                      text:
                                          " your license you can setup the company ",
                                      style: GoogleFonts.montserrat(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 15))
                                ])
                          ])),
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
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type your license key here..."),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      newButton(
                          ontap: () {
                            Navigator.pushNamed(context, "/setupCom");
                          },
                          title: "Confirm"),
                    ],
                  ),
                  SvgPicture.asset(
                    "/logo/mono_logo.svg",
                    color: Colors.white,
                    width: 55,
                  ),
                ],
              ),
            )),
          )),
    );
  }
}
