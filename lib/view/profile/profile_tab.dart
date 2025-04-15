// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:demo_bottomtab_tabbar/view/profile/widgets/profile_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:demo_bottomtab_tabbar/constants/text_string.dart';

import 'edit_profile.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  final user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tProfile, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network('${user['picture']['large']}'),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 225, 155, 33),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        LineAwesomeIcons.pencil_alt_solid,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '${user['name']['first']} ${user['name']['last']}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                '${user['email']}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => EditProfileScreen(), arguments: user);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              ProfileMenuWidget(
                title: "My Account",
                icon: LineAwesomeIcons.user,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "Settings",
                icon: LineAwesomeIcons.cog_solid,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "Help & Support",
                icon: LineAwesomeIcons.bell,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "About App",
                icon: LineAwesomeIcons.heart,
                onPress: () {},
              ),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: "Log out",
                icon: LineAwesomeIcons.sign_out_alt_solid,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
