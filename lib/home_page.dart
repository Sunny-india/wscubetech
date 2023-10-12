import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wscubetech/customer_register_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.userId});
  String? userId;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signMeOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const CustomerRegisterPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.userId!.toString()} '),
        actions: [
          IconButton(
            onPressed: signMeOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
