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
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firmNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  bool isObscured = true;

  void signUserIn() {
    print('sign in just');
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

                /// username textfield
                TextFormField(
                  controller: nameController,
                  decoration: buildInputDecoration()
                      .copyWith(hintText: 'Enter your name'),
                ),
                const MyBox(mHeight: 12),

                ///phone textfield
                TextFormField(
                  controller: phoneController,
                  decoration: buildInputDecoration()
                      .copyWith(hintText: 'Enter your phone'),
                  keyboardType: TextInputType.number,
                ),
                const MyBox(mHeight: 12),

                /// firmName textfield
                TextFormField(
                  controller: firmNameController,
                  decoration: buildInputDecoration()
                      .copyWith(hintText: 'Enter your firm\'s name'),
                ),
                const MyBox(mHeight: 12),

                /// city textfield
                TextFormField(
                  controller: cityController,
                  decoration: buildInputDecoration()
                      .copyWith(hintText: 'Enter your city'),
                ),
                const MyBox(mHeight: 12),

                /// email textfield
                TextFormField(
                  controller: emailController,
                  decoration: buildInputDecoration()
                      .copyWith(hintText: 'Enter your email'),
                ),
                const MyBox(mHeight: 12),

                /// password textfield
                TextFormField(
                  controller: passwordController,
                  decoration: buildInputDecoration().copyWith(
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey.shade500)),
                  obscureText: isObscured,
                ),
                const MyBox(mHeight: 12),

                /// forgot password
                const Text(
                  'forgot Password?',
                  textAlign: TextAlign.right,
                ),
                const MyBox(mHeight: 12),

                /// sign-in button
                MyButton(
                  onTapping: signUserIn,
                  buttonWidth: size.width * .90,
                  buttonHeight: 55,
                  buttonWidget: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white, fontSize: 29),
                  ),
                ),
                const MyBox(mHeight: 12),

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
                      imagePath: 'assets/images/googleLogo.jpg',
                      myHeight: 80,
                      myWidth: 80,
                      onTapping: signInWithGoogle,
                    ),
                    const MyBox(
                      mWidth: 12,
                    ),
                    SquareContainerForLogo(
                      imagePath: 'assets/images/appleLogo.png',
                      myHeight: 80,
                      myWidth: 80,
                      onTapping: signInWithApple,
                    )
                  ],
                ),
                MyBox(mHeight: 12),

                /// not a member? register now
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
        borderSide: const BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          12,
        ),
        borderSide: const BorderSide(color: Colors.lightBlueAccent),
      ),
      fillColor: Colors.grey.shade200,
      filled: true,
    );
  }
}