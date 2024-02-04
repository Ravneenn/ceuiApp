import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class quickChat extends StatelessWidget {
  final String profile;
  final String name;
  const quickChat({
    super.key,
    required this.profile,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 110,
        height: 130,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(profile), radius: 35),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  name,
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
