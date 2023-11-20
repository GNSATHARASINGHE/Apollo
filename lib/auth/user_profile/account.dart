import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    getCurrentUserInfo();
    super.initState();
  }

  void getCurrentUserInfo() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        nameController.text = user.displayName ?? "No Name";
        emailController.text = user.email ?? "No Email";
      } else {
        print("User not signed in");
      }
    } catch (e) {
      print("Error getting user information: $e");
    }
  }

  void _changeName(String newName) {
    setState(() {
      nameController.text = newName;
    });
  }

  void _changeEmail(String newEmail) {
    setState(() {
      emailController.text = newEmail;
    });
  }

  void _handleSubmit() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update user information in Firebase
        await user.updateDisplayName(nameController.text);
        await user.updateEmail(emailController.text);

        // Reload the user to get the updated information
        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        print('Name: ${user?.displayName}, Email: ${user?.email}');
      } else {
        print("User not signed in");
      }
    } catch (e) {
      print("Error updating user information: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
         backgroundColor: Colors.white,
        title: const Text('Account Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (newName) {
                _changeName(newName);
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (newEmail) {
                _changeEmail(newEmail);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
