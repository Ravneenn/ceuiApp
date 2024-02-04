import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class newButton extends StatelessWidget {
  final Function()? ontap;
  final String title;

  const newButton({
    super.key,
    required this.ontap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            title,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromRGBO(0, 0, 255, 1)),
          ),
        ),
      ),
    );
  }
}
