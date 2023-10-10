import 'package:apollodemo1/auth/model/user_model.dart';
import 'package:apollodemo1/auth/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'auth_helper (1).dart'; // Import the AuthHelper class

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel loggedInUser = UserModel();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid)
          .get()
          .then((value) {
        if (value.exists) {
          setState(() {
            loggedInUser = UserModel.fromMap(value.data() as Map<String, dynamic>);
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cafe Miron"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            icon: const Icon(Icons.account_circle),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 180,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Welcome to Cafe Miron",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        Text(
                          "${loggedInUser.firstName}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${loggedInUser.emailAddress}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 20,
              ),
              ActionChip(
                label: const Text("Logout"),
                onPressed: () {
                  AuthHelper.instance.logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
