import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class departmentListView extends StatelessWidget {
  final String name;
  const departmentListView({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Expanded(
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 255, 1),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
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
