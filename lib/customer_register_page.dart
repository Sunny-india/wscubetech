import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wscubetech/login_page.dart';
import 'package:wscubetech/my_widgets/my_custom_sized_box.dart';

class CustomerRegisterPage extends StatelessWidget {
  CustomerRegisterPage({super.key});
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              children: [
                const MyBox(mHeight: 50),

                /// heading label
                Transform.rotate(
                  angle: pi / 1,
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const MyBox(mHeight: 20),

                /// icon
                Container(
                  height: 200,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(-2, -2),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.grey.shade50,
                        offset: const Offset(1, 1),
                        //blurRadius: 6,
                        //spreadRadius: 1,

                        //blurRadius: 2,
                      ),
                    ],
                    // gradient: LinearGradient(
                    //     colors: [Colors.teal.shade100, Colors.teal.shade300],
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight,
                    //     stops: const [0.4, 0.99]),
                  ),
                  child: Icon(
                    CupertinoIcons.person,
                    color: Colors.grey.shade900,
                    size: 150,
                  ),
                ),
                const MyBox(mHeight: 50),

                /// email textfield
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade500,
                            offset: const Offset(-2, -2),
                            blurRadius: 2,
                            spreadRadius: 0),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(2, 2),
                          blurRadius: 1,
                          spreadRadius: 1,
                        )
                      ]),
                  child: TextFormField(
                    focusNode: FocusScopeNode(),
                    controller: nameController,
                    decoration: buildInputDecoration().copyWith(
                        prefixIcon: Icon(
                          CupertinoIcons.mail_solid,
                          color: Colors.grey.shade900,
                          size: 30,
                        ),
                        hintText: 'Enter your name'),
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return 'Please Enter email';
                      } else if (value.isValidEmail() == false) {
                        return '    enter valid email only';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          12,
        ),
        borderSide:
            const BorderSide(color: Colors.lightBlueAccent, strokeAlign: 2),
      ),
      errorStyle: const TextStyle(color: Colors.red),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      // errorBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(12),
      // ),
      // fillColor: Colors.grey.shade300,
      //filled: true,
    );
  }
}
