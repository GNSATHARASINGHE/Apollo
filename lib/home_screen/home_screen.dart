import 'package:apollodemo1/auth/user_profile/profile_page.dart';
import 'package:apollodemo1/home_screen/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeTab = 0;
  Color primary = Colors.amber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: [
        Homepage(),
       // UserPlaylistsPage(), user playlist

 Center(
          child: Text(
            "Settings",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SearchPage(),
        ProfileWidget(imagePath: imagePath, onClicked: onClicked)
       
      ],
    );
  }

  Widget getFooter() {
    List items = [
      FeatherIcons.home,
      FeatherIcons.book,
      FeatherIcons.search,
      FeatherIcons.settings,
    ];
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.black),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return IconButton(
              icon: Icon(
                items[index],
                color: activeTab == index ? primary : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  activeTab = index;
                });
              },
            );
          }),
        ),
      ),
    );
  }
}