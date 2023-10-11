import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wscubetech/login_page.dart';
import 'package:wscubetech/model/customer_data_model.dart';
import 'package:wscubetech/my_widgets/my_custom_button.dart';
import 'package:wscubetech/my_widgets/my_custom_sized_box.dart';

import 'my_widgets/my_message_handler.dart';

class CustomerRegisterPage extends StatefulWidget {
  const CustomerRegisterPage({super.key});

  @override
  State<CustomerRegisterPage> createState() => _CustomerRegisterPageState();
}

class _CustomerRegisterPageState extends State<CustomerRegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController reEnterPasswordController =
      TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController businessNameController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();
  bool isHidden = true;

  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  bool isProcessing = false;

  ///===validates name controller===///
  //because we're creating our custom function for validator
  // and until the compile time it does not know what type of
  // data would it bring back, but we're expecting a type of String?
  // so would parse that dynamic type data to string first
  // and then have that passed for further validation which we created
  // by extension method. Would happen for all the controllers.

  // learnt on 10th October-session.
  String? validatorMethodForName(value) {
    if (value!.isEmpty || value == '') {
      return 'Please Enter some name';
    } else if (value.toString().isValidName() == false) {
      return 'Use letters only';
    } else if (value.toString().isValidName() == true) {
      return null;
    } else {
      return null;
    }
  }

  ///===validates email controller===//

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

  ///===validates phone controller===///
  String? validatorMethodForPhoneNumber(value) {
    //todo: for phone number validation
    if (value!.isEmpty || value == '') {
      return 'Please Enter a valid Phone Number';
    } else if (value.toString().isValidNumber() == false) {
      return '   enter 10-digit numbers only';
    } else if (value.toString().isValidNumber() == true) {
      return null;
    } else {
      return null;
    }
  }

  ///===validates password controller===///
  static String? validatorMethodForPassword(value) {
    if (value!.isEmpty || value == '') {
      return 'Please enter password';
    } else {
      return null;
    }
  }

  ///===validates re-Enter password controller===///
  String? crossConfirmPassword(value) {
    if (value!.isEmpty || value == '') {
      return 'please re-enter password for confirming';
    } else if (value != passwordController.text) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  //todo: later to set by
  // todo: FirebaseFirestore.instance.collection.doc().set or update({});
  //  todo: method; So their textfields would also be displayed later;

  ///===validates business name controller===///
  ///===validates city name controller===///

  ///===create user with google===///

  void createUserWithEmail() async {
    //todo: login with google
    if (formKey.currentState!.validate()) {
      setState(() {
        isProcessing = true;
      });
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) async {
          await customers.doc(value.user!.uid).set(Customer(
                cid: value.user!.uid,
                name: nameController.text,
                phone: phoneController.text,
                email: emailController.text,
                businessName: '',
                city: '',
              ).toJson());
          formKey.currentState!.reset();
          setState(() {
            isProcessing = false;
          });
        });

        MyMessageHandler.showMySnackBar(
            scaffoldkey: _scaffoldkey,
            customMessage: 'User Successfully Created');

        /// the most right place to right this line to move
        /// the user to the next page only after each validation is done.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LoginPage();
            },
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          setState(() {
            isProcessing = false;
          });
          MyMessageHandler.showMySnackBar(
              scaffoldkey: _scaffoldkey, customMessage: 'email-already-in-use');
          print('User Already registered');
        } else if (e.code == 'weak-password') {
          setState(() {
            isProcessing = false;
          });
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
                      const MyBox(mHeight: 13),

                      /// heading label
                      Transform.rotate(
                        angle: pi / 1,
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 27),
                        ),
                      ),
                      const MyBox(mHeight: 20),

                      /// icon
                      Container(
                        height: 150,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(75),
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
                          size: 110,
                        ),
                      ),
                      const MyBox(mHeight: 25),

                      ///===name textField===///
                      buildContainerForContainerTFF(
                          myWidget: TextFormField(
                        controller: nameController,
                        decoration: buildInputDecoration(
                                myPrefixIcon: CupertinoIcons.person)
                            .copyWith(hintText: 'Enter your name'),
                        validator: validatorMethodForName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      )),
                      const MyBox(mHeight: 15),

                      ///===email textfield===///

                      buildContainerForContainerTFF(
                        myWidget: TextFormField(
                          controller: emailController,
                          decoration: buildInputDecoration(
                            myPrefixIcon: CupertinoIcons.mail_solid,
                          ).copyWith(hintText: 'Enter your Email'),
                          validator: validatorMethodForEmail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      const MyBox(mHeight: 15),

                      ///===phone textfiled===///
                      buildContainerForContainerTFF(
                        myWidget: TextFormField(
                          controller: phoneController,
                          decoration: buildInputDecoration(
                                  myPrefixIcon: CupertinoIcons.phone)
                              .copyWith(hintText: 'Enter your phone'),
                          keyboardType: TextInputType.number,
                          validator: validatorMethodForPhoneNumber,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        //
                      ),
                      const MyBox(mHeight: 15),

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
                          validator: validatorMethodForPassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: isHidden,
                        ),
                      ),
                      const MyBox(mHeight: 15),

                      ///===business textfield===///
                      //todo: when set or update method would be called
                      //todo: through FirebaseFirestore.instance.collection().doc();
                      // buildContainerForContainerTFF(
                      //   myWidget: TextFormField(
                      //     controller: firmNameController,
                      //     decoration: buildInputDecoration(
                      //             myPrefixIcon: CupertinoIcons.building_2_fill)
                      //         .copyWith(hintText: 'Enter your firm\'s name'),
                      //     validator: (value) {
                      //       if (value!.isEmpty || value == '') {
                      //         return 'enter business name';
                      //       } else if (value.isValidBusinessName() == false) {
                      //         return 'use letters only';
                      //       } else if (value.isValidBusinessName() == true) {
                      //         return null;
                      //       } else {
                      //         return null;
                      //       }
                      //       // todo: for business name validation
                      //     },
                      //     autovalidateMode: AutovalidateMode.onUserInteraction,
                      //   ),
                      // ),
                      // const MyBox(mHeight: 15),

                      ///===city textfield===///
                      // buildContainerForContainerTFF(
                      //   myWidget: TextFormField(
                      //     controller: cityController,
                      //     decoration: buildInputDecoration(
                      //             myPrefixIcon: CupertinoIcons.map)
                      //         .copyWith(hintText: 'Enter your city'),
                      //     validator: (value) {
                      //       //todo: city validation
                      //     },
                      //   ),

                      //
                      //),

                      ///===re-enter your password===///
                      buildContainerForContainerTFF(
                        myWidget: TextFormField(
                          controller: reEnterPasswordController,
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
                                  hintText: 're-Enter a password'),
                          validator: crossConfirmPassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: isHidden,
                        ),
                      ),
                      const MyBox(mHeight: 30),

                      /// button for login/ creating user for the first time
                      isProcessing
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.grey.shade800,
                            ))
                          : MyButton(
                              onTapping: createUserWithEmail,
                              buttonWidth: size.width * .7,
                              buttonHeight: 60,
                              buttonWidget: const FittedBox(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 29),
                                ),
                              )),
                      const MyBox(mHeight: 26),

                      ///===if user already exists===///

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already a User?',
                              style: TextStyle(fontSize: 20)),
                          const MyBox(mWidth: 14),
                          MyButton(
                              onTapping: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginPage();
                                }));
                              },
                              buttonHeight: 45,
                              buttonWidth: 70,
                              buttonWidget: const Text(
                                'Login',
                                style:
                                    TextStyle(color: Colors.teal, fontSize: 20),
                              )),
                        ],
                      ),
                      const MyBox(mHeight: 15),
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

extension ValidPhoneNumber on String {
  bool isValidNumber() {
    return RegExp(r'^[6-9][0-9]{9}$').hasMatch(this);
  }
}

//todo: to correct it
extension ValidBusinessName on String {
  bool isValidBusinessName() {
    return RegExp(r'^[a-zA-Z]+[\s]*[a-zA-Z]*[\s]*[a-zA-Z]*$').hasMatch(this);
  }
}
