import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class bigTitle extends StatelessWidget {
  final String title;
  final Color? color;
  const bigTitle({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
          color: color, fontSize: 25, fontWeight: FontWeight.w900),
    );
  }
}
