import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class bottomNavigator extends StatelessWidget {
  final String name;
  final IconData? icon;
  final Function()? ontap;
  const bottomNavigator({
    super.key,
    required this.name,
    required this.icon,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Color.fromRGBO(0, 0, 255, 1),
              size: 30,
            ),
            Text(
              name,
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
