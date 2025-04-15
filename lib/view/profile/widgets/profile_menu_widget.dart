// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 90, 166, 229),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title, style: Theme.of(context).textTheme.headlineSmall?.apply(color: textColor)),
      trailing: endIcon? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 223, 221, 221),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(LineAwesomeIcons.angle_right_solid, color: Colors.grey),
      ) : null,
    );
  }
}
