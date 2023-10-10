import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wscubetech/login_page.dart';
import 'package:wscubetech/my_widgets/my_custom_button.dart';
import 'package:wscubetech/my_widgets/my_custom_sized_box.dart';

import 'home_page.dart';
import 'my_widgets/my_message_handler.dart';

class CustomerRegisterPage extends StatefulWidget {
  const CustomerRegisterPage({super.key});

  @override
  State<CustomerRegisterPage> createState() => _CustomerRegisterPageState();
}

class _CustomerRegisterPageState extends State<CustomerRegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();
  bool isHidden = true;

  ///===validates email controller===///
  String? validatorMethodForEmail(value) {
    if (value!.isEmpty || value == '') {
      return 'Please Enter email';
    } else if (value.toString().isValidEmail() == false) {
      return '    enter valid email only';
    } else if (value.toString().isValidEmail() == true) {
      return null;
    } else {
      return null;
    }
  }

  ///===validates password controller===///
  String? validatorMethodForPassword(value) {
    if (value!.isEmpty || value == '') {
      return 'Please enter password';
    } else {
      return null;
    }
  }

  ///===create user with google===///
  void createUserWithEmail() async {
    //todo: login with google
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) {
          formKey.currentState!.reset();
          print('successfully created');
          MyMessageHandler.showMySnackBar(
              scaffoldkey: _scaffoldkey,
              customMessage: 'User Successfully Created');
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const HomePage();
          }));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          MyMessageHandler.showMySnackBar(
              scaffoldkey: _scaffoldkey, customMessage: 'email-already-in-use');
          print('User Already registered');
        } else if (e.code == 'weak-password') {
          MyMessageHandler.showMySnackBar(
              scaffoldkey: _scaffoldkey, customMessage: 'weak-password');

          print('Password is less than six digits. Not accepted');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ScaffoldMessenger(
      key: _scaffoldkey,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const MyBox(mHeight: 30),

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
                              color: Colors.grey.shade400,
                              offset: const Offset(2, 2),
                              blurRadius: 4,
                              spreadRadius: 1,

                              //blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          CupertinoIcons.person,
                          color: Colors.grey.shade900,
                          size: 150,
                        ),
                      ),
                      const MyBox(mHeight: 40),

                      /// email textfield

                      buildContainerForContainerTFF(
                        myWidget: TextFormField(
                          controller: emailController,
                          decoration: buildInputDecoration(
                            myPrefixIcon: CupertinoIcons.mail_solid,
                          ).copyWith(hintText: 'Enter your Email'),
                          validator: validatorMethodForEmail,
                          //     (value) {
                          //   if (value!.isEmpty || value == '') {
                          //     return 'Please Enter email';
                          //   } else if (value.isValidEmail() == false) {
                          //     return '    enter valid email only';
                          //   } else if (value.isValidEmail() == true) {
                          //     return null;
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      const MyBox(mHeight: 20),

                      /// password textfield
                      buildContainerForContainerTFF(
                        myWidget: TextFormField(
                          controller: passwordController,
                          decoration: buildInputDecoration(
                                  myPrefixIcon: CupertinoIcons.lock)
                              .copyWith(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isHidden = !isHidden;
                                      });
                                    },
                                    icon: Icon(
                                      isHidden
                                          ? CupertinoIcons.eye
                                          : CupertinoIcons.eye_slash,
                                    ),
                                  ),
                                  hintText: 'Set a password'),
                          validator:
                              //validatorMethodForPassword,
                              (value) {
                            if (value!.isEmpty || value == '') {
                              return 'Please enter password';
                            } else {
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: isHidden,
                        ),
                      ),

                      const MyBox(mHeight: 40),

                      /// button for login/ creating user for the first time
                      MyButton(
                          onTapping: createUserWithEmail,
                          buttonWidth: size.width,
                          buttonHeight: 70,
                          buttonWidget: const FittedBox(
                            child: Text(
                              'Sign-Up',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 80),
                            ),
                          )),
                      const MyBox(mHeight: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Already a User?',
                            style: TextStyle(fontSize: 20),
                          ),
                          const MyBox(mWidth: 14),

                          ///===if user already exists===///
                          MyButton(
                              onTapping: () {},
                              buttonHeight: 45,
                              buttonWidth: 70,
                              buttonWidget: const Text(
                                'Login',
                                style:
                                    TextStyle(color: Colors.teal, fontSize: 20),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildContainerForContainerTFF({required Widget myWidget}) {
    return Container(
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
      child: myWidget,
    );
  }

  InputDecoration buildInputDecoration({required IconData myPrefixIcon}) {
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
      prefixIcon: Icon(
        myPrefixIcon,
        color: Colors.grey.shade900,
        size: 30,
      ),
    );
  }
}
