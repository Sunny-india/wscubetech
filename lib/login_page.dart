import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wscubetech/customer_register_page.dart';
import 'package:wscubetech/my_widgets/my_message_handler.dart';

import 'my_widgets/my_container_for_logo.dart';
import 'my_widgets/my_custom_button.dart';
import 'my_widgets/my_custom_sized_box.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool isObscured = true;
  bool isProcessing = false;
  void loginUser() async {
    try {
      if (formKey.currentState!.validate()) {
        setState(() {
          isProcessing = true;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.toString(),
                password: passwordController.text.toString());
        print(userCredential.user!.email.toString());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        MyMessageHandler.showMySnackBar(
            scaffoldkey: scaffoldKey,
            customMessage: 'No user found for that email.');
        print('user not found');
      } else if (e.code == 'wrong-password') {
        MyMessageHandler.showMySnackBar(
            scaffoldkey: scaffoldKey, customMessage: 'wrong-password');
        print('wrong password entered');
      }
    }
  }

  ///===sign in with Google===///
  void signInWithGoogle() {
    print('Sign in With Google');
  }

  ///===sign in with Apple===///

  void signInWithApple() {
    print('Sign in with Apple');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MyBox(mHeight: size.height * .11),

                    ///logo
                    const Icon(
                      CupertinoIcons.lock,
                      color: Colors.black,
                      size: 100,
                    ),

                    /// Welcome back
                    Text('Welcome!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 20)),
                    const MyBox(mHeight: 20),

                    /// email textfield
                    buildContainerForTFF(
                      myChild: TextFormField(
                        controller: emailController,
                        decoration: buildInputDecoration()
                            .copyWith(hintText: 'Enter your email'),
                        validator: (value) {
                          //todo: how to call validatorMethod (which works the same)
                          //todo: from CustomerRegisterPage() here
                          if (value!.isEmpty || value == '') {
                            return 'Please Enter email';
                          } else if (value.isValidEmail() == false) {
                            return '    enter valid email only';
                          } else if (value.isValidEmail() == true) {
                            return null;
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    const MyBox(mHeight: 22),

                    /// password textfield
                    buildContainerForTFF(
                      myChild: TextFormField(
                        controller: passwordController,
                        decoration: buildInputDecoration().copyWith(
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscured = !isObscured;
                                });
                              },
                              icon: Icon(
                                isObscured
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash,
                                color: Colors.black,
                              ),
                            )),
                        obscureText: isObscured,
                        validator: (value) {
                          //todo: how to use that static method from CustomerRegisterPage;
                          if (value!.isEmpty || value == '') {
                            return 'Please enter password';
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    const MyBox(mHeight: 16),

                    /// forgot password
                    const Text('forgot Password?', textAlign: TextAlign.right),
                    const MyBox(mHeight: 32),

                    /// login button
                    MyButton(
                      onTapping: loginUser,
                      buttonWidth: size.width * .90,
                      buttonHeight: 55,
                      buttonWidget: const Text(
                        'Login',
                        style: TextStyle(color: Colors.black, fontSize: 29),
                      ),
                    ),
                    const MyBox(mHeight: 22),

                    /// or continue with
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        )),
                        const Text(
                          'Or Continue With',
                          style: TextStyle(fontSize: 20),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ))
                      ],
                    ),
                    const MyBox(mHeight: 12),

                    /// google sign-in button
                    /// apple sign-in button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareContainerForLogo(
                          onTapping: signInWithGoogle,
                          myHeight: 80,
                          myWidth: 80,
                          containerColor: Colors.grey.shade300,
                          imagePath: 'assets/images/googleLogo.jpg',
                        ),
                        const MyBox(
                          mWidth: 12,
                        ),
                        SquareContainerForLogo(
                          imagePath: 'assets/images/appleLogo.png',
                          myHeight: 80,
                          myWidth: 80,
                          containerColor: Colors.grey.shade300,
                          onTapping: signInWithApple,
                        )
                      ],
                    ),
                    const MyBox(mHeight: 32),

                    /// not a member?
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const Text(
                          'Not a member?',
                          style: TextStyle(fontSize: 20),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                    const MyBox(mHeight: 16),

                    /// register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isProcessing
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.grey.shade800,
                                ),
                              )
                            : MyButton(
                                onTapping: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const CustomerRegisterPage();
                                  }));
                                },
                                buttonHeight: 45,
                                buttonWidth: 100,
                                buttonWidget: const FittedBox(
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
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
    );
  }

  Container buildContainerForTFF({required Widget myChild}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(4, 4),
              blurRadius: 2,
              spreadRadius: 1),
          const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 2,
              spreadRadius: 1),
        ],
        gradient: LinearGradient(
            colors: [
              Colors.grey.shade200,
              Colors.grey.shade300,
              Colors.grey.shade400,
              Colors.grey.shade600
            ],
            // begin: Alignment.topLeft,
            //end: Alignment.bottomRight,
            stops: const [
              0.2,
              0.4,
              0.7,
              0.9
            ]),
      ),
      child: myChild,
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.lightBlueAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),

      // fillColor: Colors.grey.shade300,
      //filled: true,
    );
  }
}

extension ValidName on String {
  bool isValidName() {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }
}

extension ValidEmail on String {
  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9]+[_\-.]*[a-zA-Z0-9]*@[a-zA-Z]{2,}[.][a-zA-Z]{2,5}$")
        .hasMatch(this);
  }
}
