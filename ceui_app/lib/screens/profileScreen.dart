import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/changePasswordScreen.dart';
import 'package:ceui_app/screens/compLoginScreen.dart';
import 'package:ceui_app/widget/keepLogged.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class profileScreen extends StatefulWidget {
  String compId;
  String username;
  profileScreen({super.key, required this.compId, required this.username});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    Users? currentUser = usersBox.get(widget.username.toString());
    if (currentUser?.isAdmin == true) {
      return profileScreenManager(currentUser, context);
    } else if (currentUser?.isAdmin == false) {
      return profileScreenNotManager(currentUser, context);
    } else {
      return Scaffold(
        body: Text("Bir Problem var"),
      );
    }
  }

  SafeArea profileScreenManager(Users? currentUser, BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Text(
            "Profile",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Color.fromRGBO(0, 0, 255, 1),
                Color.fromRGBO(0, 93, 255, 1)
              ]),
            ),
          )),
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(0, 0, 255, 1),
                    Color.fromRGBO(0, 93, 255, 1)
                  ]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35))),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://upload.wikimedia.org/wikipedia/commons/f/f4/Nelson_Neves_picuture.gif?20151130113858"),
                              radius: 50),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${currentUser?.usName.toString()} ${currentUser?.usLastName.toString()}",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        Text(
                          "${currentUser?.usUserName.toString()}",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    profileButtons(
                      icon: Icons.password,
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => changePasswordScreen(
                                target: "user",
                                compId: widget.compId,
                                username: widget.username)));
                      },
                      title: "Change Your Password",
                    ),
                    profileButtons(
                      icon: Icons.password,
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => changePasswordScreen(
                                target: "company",
                                compId: widget.compId,
                                username: widget.username)));
                      },
                      title: "Change Company Password",
                    ),
                    profileButtons(
                      icon: Icons.logout,
                      title: "Log out",
                      ontap: () {
                        clearStorage();
                        Navigator.pushAndRemoveUntil<void>(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const compLogin()),
                          ModalRoute.withName('/'),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  SafeArea profileScreenNotManager(Users? currentUser, BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Text(
            "Profile",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Color.fromRGBO(0, 0, 255, 1),
                Color.fromRGBO(0, 93, 255, 1)
              ]),
            ),
          )),
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(0, 0, 255, 1),
                    Color.fromRGBO(0, 93, 255, 1)
                  ]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35))),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://upload.wikimedia.org/wikipedia/commons/f/f4/Nelson_Neves_picuture.gif?20151130113858"),
                              radius: 50),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${currentUser?.usName.toString()} ${currentUser?.usLastName.toString()}",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        Text(
                          "${currentUser?.usUserName.toString()}",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    profileButtons(
                      icon: Icons.password,
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => changePasswordScreen(
                                target: "user",
                                compId: widget.compId,
                                username: widget.username)));
                      },
                      title: "Change Your Password",
                    ),
                    profileButtons(
                      icon: Icons.logout,
                      title: "Log out",
                      ontap: () {
                        clearStorage();
                        Navigator.pushAndRemoveUntil<void>(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const compLogin()),
                          ModalRoute.withName('/'),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class profileButtons extends StatelessWidget {
  final String title;
  final Function()? ontap;
  final IconData icon;
  const profileButtons({
    super.key,
    required this.title,
    required this.ontap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              color: Color.fromRGBO(0, 0, 255, 0.1)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Row(
              children: [
                Icon(icon),
                SizedBox(
                  width: 15,
                ),
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
