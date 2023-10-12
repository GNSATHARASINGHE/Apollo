
import 'package:apollodemo1/auth/registration_screen%20(2).dart';
import 'package:apollodemo1/auth/user_profile/reset_passsword.dart';
import 'package:apollodemo1/home_screen/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



import 'auth_helper (1).dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _isPasswordVisible = false; // Track password visibility

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signInWithEmailPassword() async {
    final AuthHelper authHelper = AuthHelper.instance;
    final String email = emailController.text;
    final String password = passwordController.text;

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final User? user =
          await authHelper.signInWithEmailAndPassword(email, password);

      if (user != null) {
        Fluttertoast.showToast(msg: "Login Successful");

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Login Failed. Please check your credentials.");
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid Email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final passwordField = Stack(
      children: [
        TextFormField(
          autofocus: false,
          controller: passwordController,
          obscureText: !_isPasswordVisible, // Toggle password visibility
          validator: (value) {
            RegExp regex = RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Password Is Required");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter Valid Password (Min. 6 Characters)");
            }
            return null;
          },
          onSaved: (value) {
            passwordController.text = value!;
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off, // Toggle password visibility
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
              });
            },
          ),
        ),
      ],
    );

    final loginButton = Stack(
      children: [
        Material(
          elevation: 5,
          color: Color.fromARGB(255, 14, 1, 1),
          borderRadius: BorderRadius.circular(30),
          child: MaterialButton(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width * 0.5,
            onPressed: () {
              signInWithEmailPassword();
            },
            child: const Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (_isLoading)
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: _isLoading,
            child: const CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
      ],
    );

    Widget forgetPassword(BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 35,
        alignment: Alignment.bottomRight,
        child: TextButton(
          child: const Text(
            "Forget Password ?",
            style: TextStyle(color: Colors.orange),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ResetPassScreen()));
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/logo.png",
                        width: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    emailField,
                    const SizedBox(
                      height: 20,
                    ),
                    passwordField,
                    const SizedBox(
                      height: 10,
                    ),
                    forgetPassword(context),
                    loginButton,
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegistrationScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "SignUp",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color.fromARGB(255, 11, 0, 0),
                            ),
                          ),

                          
                        )
                        
                      ],
                    )
                  ],
                  
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
