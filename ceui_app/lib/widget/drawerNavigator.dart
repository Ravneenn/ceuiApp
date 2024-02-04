import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class drawerNavigator extends StatelessWidget {
  final Function()? ontap;
  final String name;
  final IconData? icon;
  const drawerNavigator({
    super.key,
    required this.ontap,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
