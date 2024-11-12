import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soundscape/screens/homeScreens/HomeScreen.dart';
import 'package:soundscape/screens/signupAndLogin/login_screen.dart';

class FirebaseAuthScreen extends StatefulWidget {
  const FirebaseAuthScreen({super.key});

  @override
  State<FirebaseAuthScreen> createState() => _FirebaseAuthScreenState();
}

class _FirebaseAuthScreenState extends State<FirebaseAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("${snapshot.data}🔥🔥");
            return Homescreen();
          } else {
          print("noData🔥🔥");
            return LoginScreen();
          }
        },
      ),
    );
  }
}
