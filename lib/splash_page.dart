import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   takeMeToLoginOrHomePage();
  //   // TODO: implement initState
  //   super.initState();
  // }

  // void takeMeToLoginScreen() {
  //   Timer(const Duration(seconds: 3), () async {
  //     await Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (context) {
  //       return const LoginPage();
  //     }));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.teal,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            /// it means the user is logged in///
            return const HomePage();
          } else {
            /// it means the user is not logged in ///
            return const LoginPage();
          }
        },
      ),
    );
  }
}
