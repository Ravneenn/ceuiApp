import 'package:ceui_app/Reports.dart';
import 'package:ceui_app/Tasks.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/changePasswordScreen.dart';
import 'package:ceui_app/screens/compLoginScreen.dart';
import 'package:ceui_app/screens/personalsScreen.dart';
import 'package:ceui_app/screens/profileScreen.dart';
import 'package:ceui_app/screens/reportsScreen.dart';
import 'package:ceui_app/screens/tasksScreen.dart';
import 'package:ceui_app/widget/bigTitle.dart';
import 'package:ceui_app/widget/homeScreenSize.dart';
import 'package:ceui_app/widget/keepLogged.dart';
import 'package:ceui_app/widget/reportWidgetForHomeScreen.dart';
import 'package:ceui_app/widget/responsive.dart';
import 'package:ceui_app/widget/taskWidgetForHomeScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../Companies.dart';
import '../Users.dart';

// ignore: must_be_immutable
class home extends StatefulWidget {
  String compId;
  String username;
  Box<Companies> compBox;
  Box<Users> compUsers;
  home(
      {super.key,
      required this.compBox,
      required this.compUsers,
      required this.compId,
      required this.username});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Screen device = Screen.mobile;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    setState(() {
      device = detectScreen(deviceSize);
    });
    if (device == Screen.mobile) {
      return homeScreen(
          compBox: widget.compBox,
          compUsers: widget.compUsers,
          compId: widget.compId,
          username: widget.username);
    } else {
      return homeScreenTablet(
          dSize: deviceSize,
          compBox: widget.compBox,
          compUsers: widget.compUsers,
          compId: widget.compId,
          username: widget.username);
    }
  }
}

// ignore: must_be_immutable
class homeScreen extends StatefulWidget {
  String compId;
  String username;
  Box<Companies> compBox;
  Box<Users> compUsers;
  homeScreen(
      {super.key,
      required this.compBox,
      required this.compUsers,
      required this.compId,
      required this.username});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  ValueListenable<Box<Reports>> listenToReports() => reportsBox.listenable();
  ValueListenable<Box<Tasks>> listenToTasks() => tasksBox.listenable();
  @override
  Widget build(BuildContext context) {
    Users? currentUser = widget.compUsers.get(widget.username.toString());
    if (currentUser?.isAdmin == true) {
      return homeScreenManager(context, currentUser);
    } else if (currentUser?.isAdmin == false) {
      return homeScreenNotManager(context, currentUser);
    } else {
      return Scaffold(
        body: Text("Bir Problem var"),
      );
    }
  }

  SafeArea homeScreenManager(BuildContext context, Users? currentUser) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(0, 0, 255, 1),
              Color.fromRGBO(0, 93, 255, 1)
            ])),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => profileScreen(
                                      compId: widget.compId,
                                      username: widget.username)));
                            },
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://upload.wikimedia.org/wikipedia/commons/f/f4/Nelson_Neves_picuture.gif?20151130113858"),
                                  radius: 25),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat("EEEE, d MMM, yyyy")
                                    .format(DateTime.now())
                                    .toString(),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14),
                              ),
                              Text(
                                "${currentUser?.usName.toString()} ${currentUser?.usLastName.toString()}",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: bigTitle(
                                        title: "Latest Reports",
                                        color: Colors.white),
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: listenToReports(),
                                      builder: (ctx, Box<Reports> box,
                                          Widget? child) {
                                        var reports = [];
                                        for (var i = 0; i < box.length; i++) {
                                          if (box.getAt(i)?.compId ==
                                              widget.compId.toString()) {
                                            reports.add(box.getAt(i));
                                          }
                                        }
                                        reports.sort(
                                          (a, b) {
                                            String dateA = a.date.toString();
                                            String dateB = b.date.toString();
                                            return dateB.compareTo(dateA);
                                          },
                                        );

                                        return reports.isNotEmpty
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              (96 / 100),
                                                      height: 100,
                                                      child:
                                                          SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis
                                                                      .horizontal,
                                                              child: reports
                                                                          .length >=
                                                                      3
                                                                  ? Row(
                                                                      children: [
                                                                        ReportWidgetForHomeScreen(
                                                                            report:
                                                                                reports[0]),
                                                                        ReportWidgetForHomeScreen(
                                                                            report:
                                                                                reports[1]),
                                                                        ReportWidgetForHomeScreen(
                                                                            report:
                                                                                reports[2]),
                                                                      ],
                                                                    )
                                                                  : reports.length >=
                                                                          2
                                                                      ? Row(
                                                                          children: [
                                                                            ReportWidgetForHomeScreen(report: reports[0]),
                                                                            ReportWidgetForHomeScreen(report: reports[1]),
                                                                          ],
                                                                        )
                                                                      : reports.length >=
                                                                              1
                                                                          ? Row(
                                                                              children: [
                                                                                ReportWidgetForHomeScreen(report: reports[0])
                                                                              ],
                                                                            )
                                                                          : Text(
                                                                              "No reports to show",
                                                                              style: GoogleFonts.montserrat(color: Colors.white),
                                                                            )))
                                                ],
                                              )
                                            : Center(
                                                child: Text(
                                                "No reports to show",
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ));
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(35))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 8),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          bigTitle(
                                              title: "Manager Modules",
                                              color: Colors.black),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        menuItemsWidget(
                                          name: "Tasks",
                                          url:
                                              "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA1L25zMjA4MC1pbWFnZS1rd3Z5Y2g3dy5qcGc.jpg",
                                          ontap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        tasksScreen(
                                                            compBox:
                                                                widget.compBox,
                                                            compId:
                                                                widget.compId,
                                                            compUsers: widget
                                                                .compUsers,
                                                            username: widget
                                                                .username)));
                                          },
                                        ),
                                        menuItemsWidget(
                                          name: "Reports",
                                          url:
                                              "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdXB3azU4ODU0NTk0LXdpa2ltZWRpYS1pbWFnZS1rb3dydTBscS5qcGc.jpg",
                                          ontap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        reportsScreen(
                                                            compBox:
                                                                widget.compBox,
                                                            compId:
                                                                widget.compId,
                                                            compUsers: widget
                                                                .compUsers,
                                                            username: widget
                                                                .username)));
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        menuItemsWidget(
                                          name: "Staffs",
                                          url:
                                              "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvay0xMF9kc2MyNzEwX2FydC5qcGc.jpg",
                                          ontap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        personalsScreen(
                                                            compBox:
                                                                widget.compBox,
                                                            compId:
                                                                widget.compId,
                                                            compUsers: widget
                                                                .compUsers,
                                                            username: widget
                                                                .username)));
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SafeArea homeScreenNotManager(BuildContext context, Users? currentUser) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Center(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(0, 0, 255, 1),
              Color.fromRGBO(0, 93, 255, 1)
            ])),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => profileScreen(
                                      compId: widget.compId,
                                      username: widget.username)));
                            },
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://upload.wikimedia.org/wikipedia/commons/f/f4/Nelson_Neves_picuture.gif?20151130113858"),
                                  radius: 25),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat("EEEE, d MMM, yyyy")
                                    .format(DateTime.now())
                                    .toString(),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14),
                              ),
                              Text(
                                "${currentUser?.usName.toString()} ${currentUser?.usLastName.toString()}",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: bigTitle(
                                        title: "Tasks: Closer Deadline",
                                        color: Colors.white),
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: listenToTasks(),
                                      builder:
                                          (ctx, Box<Tasks> box, Widget? child) {
                                        var tasks = [];
                                        for (var i = 0; i < box.length; i++) {
                                          if (box.getAt(i)?.apoointed ==
                                                  widget.username.toString() &&
                                              box.getAt(i)?.compId ==
                                                  widget.compId.toString()) {
                                            tasks.add(box.getAt(i));
                                          }
                                        }
                                        tasks.sort(
                                          (a, b) {
                                            String dateA =
                                                a.deadline.toString();
                                            String dateB =
                                                b.deadline.toString();
                                            return dateB.compareTo(dateA);
                                          },
                                        );
                                        return SizedBox(
                                            height: 80,
                                            child: tasks.isNotEmpty
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              (96 / 100),
                                                          height: 80,
                                                          child: SingleChildScrollView(
                                                              scrollDirection: Axis.horizontal,
                                                              child: tasks.length >= 3
                                                                  ? Row(
                                                                      children: [
                                                                        TaskWidgetForHomeScreen(
                                                                            task:
                                                                                tasks[0]),
                                                                        TaskWidgetForHomeScreen(
                                                                            task:
                                                                                tasks[1]),
                                                                        TaskWidgetForHomeScreen(
                                                                            task:
                                                                                tasks[2]),
                                                                      ],
                                                                    )
                                                                  : tasks.length >= 2
                                                                      ? Row(
                                                                          children: [
                                                                            TaskWidgetForHomeScreen(task: tasks[0]),
                                                                            TaskWidgetForHomeScreen(task: tasks[1]),
                                                                          ],
                                                                        )
                                                                      : tasks.length >= 1
                                                                          ? Row(
                                                                              children: [
                                                                                TaskWidgetForHomeScreen(task: tasks[0]),
                                                                              ],
                                                                            )
                                                                          : Text(
                                                                              "No tasks to show",
                                                                              style: GoogleFonts.montserrat(color: Colors.white),
                                                                            )))
                                                    ],
                                                  )
                                                : Center(
                                                    child: Text(
                                                    "No tasks to show",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                  )));
                                      })
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(35))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 8),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          bigTitle(
                                              title: "Staff Modules",
                                              color: Colors.black),
                                        ],
                                      ),
                                    ),
                                    menuItems2Widget(
                                      name: "My Tasks",
                                      url:
                                          "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA1L25zMjA4MC1pbWFnZS1rd3Z5Y2g3dy5qcGc.jpg",
                                      ontap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    tasksScreen(
                                                        compBox: widget.compBox,
                                                        compId: widget.compId,
                                                        compUsers:
                                                            widget.compUsers,
                                                        username:
                                                            widget.username)));
                                      },
                                    ),
                                    menuItems2Widget(
                                      name: "My Reports",
                                      url:
                                          "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdXB3azU4ODU0NTk0LXdpa2ltZWRpYS1pbWFnZS1rb3dydTBscS5qcGc.jpg",
                                      ontap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    reportsScreen(
                                                        compBox: widget.compBox,
                                                        compId: widget.compId,
                                                        compUsers:
                                                            widget.compUsers,
                                                        username:
                                                            widget.username)));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  itemCountWidget(List list) {
    if (list.length < 3) {
      return list.length;
    } else {
      return 3;
    }
  }
}

// ignore: must_be_immutable
class homeScreenTablet extends StatefulWidget {
  Size dSize;
  String compId;
  String username;
  Box<Companies> compBox;
  Box<Users> compUsers;
  homeScreenTablet(
      {super.key,
      required this.dSize,
      required this.compBox,
      required this.compUsers,
      required this.compId,
      required this.username});

  @override
  State<homeScreenTablet> createState() => _homeScreenTabletState();
}

class _homeScreenTabletState extends State<homeScreenTablet> {
  ValueListenable<Box<Reports>> listenToReports() => reportsBox.listenable();
  ValueListenable<Box<Tasks>> listenToTasks() => tasksBox.listenable();
  @override
  Widget build(BuildContext context) {
    Users? currentUser = widget.compUsers.get(widget.username.toString());
    if (currentUser?.isAdmin == true) {
      return homeScreenTabletManager(currentUser, context);
    } else if (currentUser?.isAdmin == false) {
      return homeScreenTabletNotManager(currentUser, context);
    } else {
      return Scaffold(
        body: Text("Bir Problem var"),
      );
    }
  }

  Scaffold homeScreenTabletManager(Users? currentUser, BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          Container(
            width: hSize(45, widget.dSize),
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(0, 0, 255, 1),
                  Color.fromRGBO(0, 93, 255, 1)
                ]),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(hSize(2, widget.dSize)),
                    bottomRight: Radius.circular(hSize(2, widget.dSize)))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/commons/f/f4/Nelson_Neves_picuture.gif?20151130113858"),
                            radius: 60),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "${currentUser?.usName.toString()} ${currentUser?.usLastName.toString()}",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      ),
                      Text(
                        "${currentUser?.usUserName.toString()}",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      profileButtonTablet(
                        widget: widget,
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
                      profileButtonTablet(
                        widget: widget,
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
                    ],
                  ),
                ),
                Column(
                  children: [
                    profileButtonTablet(
                      widget: widget,
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  bigTitle(title: "Latest Reports:", color: Colors.black),
                  ValueListenableBuilder(
                      valueListenable: listenToReports(),
                      builder: (ctx, Box<Reports> box, Widget? child) {
                        var reports = [];
                        for (var i = 0; i < box.length; i++) {
                          if (box.getAt(i)?.compId ==
                              widget.compId.toString()) {
                            reports.add(box.getAt(i));
                          }
                        }
                        reports.sort(
                          (a, b) {
                            String dateA = a.date.toString();
                            String dateB = b.date.toString();
                            return dateB.compareTo(dateA);
                          },
                        );
                        return SizedBox(
                          height: 100,
                          child: reports.isNotEmpty
                              ? ListView.builder(
                                  itemCount: itemCountWidget(reports),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var report = reports[index];
                                    return ReportWidgetForHomeScreenTablet(
                                        report: report);
                                  },
                                )
                              : Center(
                                  child: Text(
                                  "No reports to show",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black, fontSize: 20),
                                )),
                        );
                      }),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              menuItemsTablet(
                                name: "Tasks",
                                url:
                                    "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA1L25zMjA4MC1pbWFnZS1rd3Z5Y2g3dy5qcGc.jpg",
                                ontap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => tasksScreen(
                                          compBox: widget.compBox,
                                          compId: widget.compId,
                                          compUsers: widget.compUsers,
                                          username: widget.username)));
                                },
                              ),
                              menuItemsTablet(
                                name: "Reports",
                                url:
                                    "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdXB3azU4ODU0NTk0LXdpa2ltZWRpYS1pbWFnZS1rb3dydTBscS5qcGc.jpg",
                                ontap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => reportsScreen(
                                          compBox: widget.compBox,
                                          compId: widget.compId,
                                          compUsers: widget.compUsers,
                                          username: widget.username)));
                                },
                              ),
                              menuItemsTablet(
                                name: "Staffs",
                                url:
                                    "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvay0xMF9kc2MyNzEwX2FydC5qcGc.jpg",
                                ontap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => personalsScreen(
                                          compBox: widget.compBox,
                                          compId: widget.compId,
                                          compUsers: widget.compUsers,
                                          username: widget.username)));
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Scaffold homeScreenTabletNotManager(
      Users? currentUser, BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          Container(
            width: hSize(45, widget.dSize),
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(0, 0, 255, 1),
                  Color.fromRGBO(0, 93, 255, 1)
                ]),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(hSize(2, widget.dSize)),
                    bottomRight: Radius.circular(hSize(2, widget.dSize)))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/commons/f/f4/Nelson_Neves_picuture.gif?20151130113858"),
                            radius: 60),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "${currentUser?.usName.toString()} ${currentUser?.usLastName.toString()}",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      ),
                      Text(
                        "${currentUser?.usUserName.toString()}",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      profileButtonTablet(
                        widget: widget,
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
                    ],
                  ),
                ),
                Column(
                  children: [
                    profileButtonTablet(
                        widget: widget,
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
                        }),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  bigTitle(
                      title: "Tasks: Closer Deadline", color: Colors.black),
                  ValueListenableBuilder(
                      valueListenable: listenToTasks(),
                      builder: (ctx, Box<Tasks> box, Widget? child) {
                        var tasks = [];
                        for (var i = 0; i < box.length; i++) {
                          if (box.getAt(i)?.apoointed ==
                                  widget.username.toString() &&
                              box.getAt(i)?.compId ==
                                  widget.compId.toString()) {
                            tasks.add(box.getAt(i));
                          }
                        }
                        tasks.sort(
                          (a, b) {
                            String dateA = a.deadline.toString();
                            String dateB = b.deadline.toString();
                            return dateA.compareTo(dateB);
                          },
                        );
                        return SizedBox(
                          height: 100,
                          child: tasks.isNotEmpty
                              ? ListView.builder(
                                  itemCount: itemCountWidget(tasks),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var task = tasks[index];
                                    return TaskWidgetForHomeScreenTablet(
                                        task: task);
                                  },
                                )
                              : Center(
                                  child: Text(
                                  "No writed reports to show",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black, fontSize: 20),
                                )),
                        );
                      }),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              menuItemsTablet(
                                name: "My Tasks",
                                url:
                                    "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA1L25zMjA4MC1pbWFnZS1rd3Z5Y2g3dy5qcGc.jpg",
                                ontap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => tasksScreen(
                                          compBox: widget.compBox,
                                          compId: widget.compId,
                                          compUsers: widget.compUsers,
                                          username: widget.username)));
                                },
                              ),
                              menuItemsTablet(
                                name: "My Reports",
                                url:
                                    "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdXB3azU4ODU0NTk0LXdpa2ltZWRpYS1pbWFnZS1rb3dydTBscS5qcGc.jpg",
                                ontap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => reportsScreen(
                                          compBox: widget.compBox,
                                          compId: widget.compId,
                                          compUsers: widget.compUsers,
                                          username: widget.username)));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  itemCountWidget(List list) {
    if (list.length < 3) {
      return list.length;
    } else {
      return 3;
    }
  }
}

// ignore: must_be_immutable
class menuItemsTablet extends StatelessWidget {
  String name;
  String url;
  Function()? ontap;
  menuItemsTablet({required this.name, required this.url, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 189,
          decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: 0.65,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    url,
                  )),
              color: Color.fromRGBO(0, 0, 0, 0.095),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              name,
              style: GoogleFonts.montserrat(
                  color: Color.fromRGBO(0, 0, 255, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}

class profileButtonTablet extends StatelessWidget {
  final String title;
  final Function()? ontap;
  final IconData icon;
  const profileButtonTablet({
    super.key,
    required this.widget,
    required this.icon,
    required this.title,
    required this.ontap,
  });

  final homeScreenTablet widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          width: hSize(43, widget.dSize),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Row(
              children: [
                Icon(
                  icon,
                ),
                SizedBox(
                  width: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: hSize(34, widget.dSize),
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class menuItemsWidget extends StatelessWidget {
  String name;
  String url;
  Function()? ontap;
  menuItemsWidget({required this.name, required this.url, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: ontap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 220,
            height: 260,
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: 0.65,
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.color),
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      url,
                    )),
                color: Color.fromRGBO(0, 0, 0, 0.095),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Text(
                name,
                style: GoogleFonts.montserrat(
                    color: Color.fromRGBO(0, 0, 255, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class menuItems2Widget extends StatelessWidget {
  String name;
  String url;
  Function()? ontap;
  menuItems2Widget(
      {required this.name, required this.url, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 260,
          decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: 0.65,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    url,
                  )),
              color: Color.fromRGBO(0, 0, 0, 0.095),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              name,
              style: GoogleFonts.montserrat(
                  color: Color.fromRGBO(0, 0, 255, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
