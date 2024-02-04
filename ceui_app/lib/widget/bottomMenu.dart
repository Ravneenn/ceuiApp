import 'package:ceui_app/widget/bottomNavigator.dart';
import 'package:flutter/material.dart';

class bottomMenu extends StatelessWidget {
  const bottomMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Divider(
            height: 15,
            color: Color.fromRGBO(0, 0, 255, 1),
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: bottomNavigator(
                  name: "Profile",
                  icon: Icons.person,
                  ontap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/profile', (route) => false);
                  },
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: bottomNavigator(
                  name: "Chat",
                  icon: Icons.notes,
                  ontap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/main', (route) => false);
                  },
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: bottomNavigator(
                  name: "Settings",
                  icon: Icons.settings,
                  ontap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              )),
            ],
          )
        ],
      ),
    );
  }
}
