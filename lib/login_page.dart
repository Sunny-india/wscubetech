import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isObscured = true;

  void signUserIn() async {
    if (formkey.currentState!.validate()) {
      /// show loading circle
      /// and at the end of this function have that popped
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return const Center(
      //         child: CircularProgressIndicator(
      //           color: Colors.deepPurple,
      //         ),
      //       );
      //     });

      ///===sending user data to firebase and having
      /// it checked if it exists or not.
      /// When successful, it also allows users to call
      /// their authStateChanges, itTokenChanges, or userChanges
      /// based on authStateChanges, we can always send our user
      /// to different pages from SplashScreen.===///

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        print('sign in just');
        formkey.currentState!.reset();

        /// at this point the authStateChanges method would listen
        /// and for that we've set its behaviour already in SplashScreen
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('User Not Found');
          //todo: ScaffoldMessenger or AlertDialog to be used here
        }
        if (e.code == 'wrong-password') {
          print('Wrong Password');
          //todo: ScaffoldMessenger or AlertDialog to be used here
        }
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
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formkey,
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
                  Text(
                    'Welcome!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 20),
                  ),
                  const MyBox(mHeight: 20),

                  /// email textfield
                  buildContainerForTFF(
                    myChild: TextFormField(
                      controller: emailController,
                      decoration: buildInputDecoration()
                          .copyWith(hintText: 'Enter your email'),
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
                            icon: const Icon(
                              CupertinoIcons.eye,
                              color: Colors.black,
                            ),
                          )),
                      obscureText: isObscured,
                    ),
                  ),
                  const MyBox(mHeight: 16),

                  /// forgot password
                  const Text(
                    'forgot Password?',
                    textAlign: TextAlign.right,
                  ),
                  const MyBox(mHeight: 32),

                  /// sign-in button
                  MyButton(
                    onTapping: signUserIn,
                    buttonWidth: size.width * .90,
                    buttonHeight: 55,
                    buttonWidget: const Text(
                      'Sign In',
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
                      const Text('Or Continue With'),
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
                  const MyBox(mHeight: 12),

                  /// not a member? register now
                ],
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
