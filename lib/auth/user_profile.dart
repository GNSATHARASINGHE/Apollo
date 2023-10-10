
import 'package:apollodemo1/auth/update_profile.dart';
import 'package:apollodemo1/home_screen/home_page.dart';
import 'package:flutter/material.dart';

import 'auth_helper (1).dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Homepage()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Center(
          child: Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.star_border_purple500_outlined,
                color: (Colors.black),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset("assets/images/pro_pic.png"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "UserName",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
                const Text(
                  "email",
                  style: TextStyle(fontSize: 19),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => UpdateProfile()),
                      );
                    },
                    child: const Text("Edit Profile"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 20,
                ),

                ///Menu
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),

                  child: Column(
                    children: [
                      const Divider(),
                      proMod(
                        title: "Settings",
                        icon: Icons.settings,
                        onPress: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      proMod(
                        title: "Billing Details",
                        icon: Icons.wallet,
                        onPress: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      proMod(
                          title: "User Management",
                          icon: Icons.person_outline_outlined,
                          onPress: () {}),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      proMod(
                          title: "Information",
                          icon: Icons.info_outline,
                          onPress: () {}),
                      const SizedBox(
                        height: 10,
                      ),
                      proMod(
                          title: "LogOut",
                          icon: Icons.logout,
                          textColor: Colors.red,
                          endIcon: false,
                          onPress: () {
                            AuthHelper.instance.logout(context);
                          }),
                    ],
                  ),
                  // child: proMod(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class proMod extends StatelessWidget {
  const proMod({
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
    super.key,
  });

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
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blueGrey.withOpacity(0.3),
        ),
        child: Icon(
          icon,
          // size: 40,
          color: Colors.redAccent,
        ),
      ),
      title: Text(
        title,
      ),
      trailing: endIcon
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.05),
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                //color: Colors.blue,
              ),
            )
          : null,
    );
  }
}
