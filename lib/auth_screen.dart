import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum signOption {
  login,
  signup,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailtextEditingController = TextEditingController();
  final _passwordtextEditingController = TextEditingController();
  signOption signingOption = signOption.login;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void toggleMode() {
    if (signingOption == signOption.login) {
      setState(() {
        signingOption = signOption.signup;
      });
    } else {
      setState(() {
        signingOption = signOption.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(signingOption == signOption.login ? "Login" : "Sign up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _emailtextEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
            ),
            TextField(
              controller: _passwordtextEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    if (signingOption == signOption.login) {
                      UserCredential user =
                          await _auth.signInWithEmailAndPassword(
                              email: _emailtextEditingController.text,
                              password: _passwordtextEditingController.text);
                      print(user.user!.email);
                    } else {
                      UserCredential user =
                          await _auth.createUserWithEmailAndPassword(
                              email: _emailtextEditingController.text,
                              password: _passwordtextEditingController.text);
                      print(user.user!.email);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Text(
                    signingOption == signOption.login ? "Login" : "Sign up")),
            TextButton(
                onPressed: () {
                  toggleMode();
                },
                child: Text(
                    signingOption == signOption.login ? "Sign up" : "Login"))
          ],
        ),
      ),
    );
  }
}
