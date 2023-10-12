import 'package:apollodemo1/pages/homepage.dart';
import 'package:apollodemo1/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/user_preferences.dart';
import '../../widget/appbar_widget.dart';
import '../../widget/button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(imagePath), // You can use NetworkImage or AssetImage depending on your image source
      ),
    );
  }
}


 Widget buildName(User user) => Column(
  children: [
    Text(
      user.uid,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    ),
    const SizedBox(height: 4),
    Text(
      user.email ?? '', // Use the null-aware operator and provide a default value
      style: TextStyle(color: Colors.grey),
    )
  ],
);
Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To PRO',
        onClicked: () {},
      );

