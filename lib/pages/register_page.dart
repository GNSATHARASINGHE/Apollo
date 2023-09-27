import 'package:apollodemo1/components/sign_btn.dart';
import 'package:apollodemo1/components/squaretile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../components/textfield.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({
    Key? key, // Added the missing key parameter
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  PickedFile? imageFile;
  final ImagePicker _picker = ImagePicker();

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        showErrorMessage("Passwords don't match!");
      }

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showImageSourceDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Choose Profile Photo Source'),
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Camera'),
              onTap: () {
                takePhoto(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Gallery'),
              onTap: () {
                takePhoto(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

void takePhoto(ImageSource source) async {
  final pickedFile = await _picker.pickImage(
    source: source,
  );

  if (pickedFile != null) {
    setState(() {
      imageFile = PickedFile(pickedFile.path);
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                // Profile Image Placeholder
               Stack(
  alignment: Alignment.bottomRight,
  children: [
    CircleAvatar(
      radius: 80.0,
      backgroundImage: imageFile == null
        ? const AssetImage("assets/me1.jpg")
        : FileImage(File(imageFile!.path)) as ImageProvider<Object>,
    ),
    IconButton(
      onPressed: _showImageSourceDialog,
      icon: Icon(
        Icons.camera_alt,
        color: Colors.teal,
        size: 28.0,
      ),
    ),
  ],
),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.camera),
                      onPressed: () {
                        takePhoto(ImageSource.camera);
                      },
                      label: Text("Camera"),
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        takePhoto(ImageSource.gallery);
                      },
                      label: Text("Gallery"),
                    )
                  ],
                ),
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 25),
                Textfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                Textfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Textfield(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Textfield(
                  controller: fNameController,
                  hintText: 'First Name',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                Textfield(
                  controller: lNameController,
                  hintText: 'Last Name',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Lg_btn(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),
                const SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SqTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: "assets/google.png"),
                    SizedBox(width: 25),
                    SqTile(onTap: () => {}, imagePath: "assets/apple.png")
                  ],
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
