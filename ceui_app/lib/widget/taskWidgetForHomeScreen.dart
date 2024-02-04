import 'package:ceui_app/Tasks.dart';
import 'package:ceui_app/Users.dart';
import 'package:ceui_app/boxes.dart';
import 'package:ceui_app/screens/tasksViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskWidgetForHomeScreen extends StatelessWidget {
  final Tasks? task;
  const TaskWidgetForHomeScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Users? appointer = usersBox.get(task!.appointer.toString());

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Expanded(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => tasksView(task: task)));
          },
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      task!.taskName,
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Row(
                      children: [
                        Text(
                          "From: ",
                          style: GoogleFonts.montserrat(
                              color: Color.fromRGBO(0, 0, 255, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Text(
                          "${appointer?.usName} ${appointer?.usLastName}",
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TaskWidgetForHomeScreenTablet extends StatelessWidget {
  final Tasks? task;
  const TaskWidgetForHomeScreenTablet({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Users? appointer = usersBox.get(task!.appointer.toString());

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => tasksView(task: task)));
        },
        child: Container(
          width: (MediaQuery.of(context).size.width * (16.45 / 100)),
          height: 50,
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 255, 1),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width * (16.4 / 100)),
                    child: Text(
                      task!.taskName,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Text(
                    "From: ",
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width * (16.4 / 100)),
                    child: Text(
                      "${appointer?.usName} ${appointer?.usLastName}",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
