import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healjai/constants/color.dart';
import 'package:healjai/constants/routes.dart';

import '../utilities/custom_text_field/lemail_text_field.dart';
import '../utilities/custom_text_field/lpassword_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             const Text('Log in page'),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pushNamedAndRemoveUntil(
  //                   // navigates to homeRoute screen and removes previous routes
  //                   registerRoute,
  //                   (route) => false,
  //                 );
  //               },
  //               child: const Text('Register'),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pushNamedAndRemoveUntil(
  //                   // navigates to homeRoute screen and removes previous routes
  //                   homeRoute,
  //                   (route) => false,
  //                 );
  //               },
  //               child: const Text('Home'),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  bool _isEmailValid = true;
  bool _isPasswordOk = true;
  bool _isSomeThingWrong = false;
  bool isKeyboardVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is already signed in
      Future.delayed(Duration.zero, () async {
        await Navigator.of(context).pushNamedAndRemoveUntil(
          // navigates to homeRoute screen and removes previous routes
          homeRoute,
          (route) => false,
        );
      });
    } else {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Welcome to",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                        ),
                      ),
                      Text(
                        "HealJai !",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                        ),
                      ),
                      Text(
                        "Login to your account",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          height: 2.5,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email form
                        EmailTextField(
                          controller: emailController,
                          isEmailValid: _isEmailValid,
                          focusNode: emailFocusNode,
                        ),
                        // Password form
                        PasswordTextField(
                            passwordController: passwordController,
                            isPasswordOk: _isPasswordOk),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              if (_isSomeThingWrong)
                                const Text(
                                  "Please make sure that you log in with the correct email and password",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 7, 32, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final email = emailController.text;
                          final password = passwordController.text;
                          if (_formKey.currentState!.validate()) {
                            // Do something if the form is valid
                            // For example, check if the email is valid
                            if (_isValidEmail(emailController.text) &&
                                passwordController.value.text.length >= 6) {
                              if (mounted) {
                                setState(() {
                                  _isEmailValid = true;
                                  _isPasswordOk = true;
                                  _isSomeThingWrong = false;
                                });
                              }
                              try {
                                try {
                                  // This is sign in with firebase
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: email, password: password);
                                  //     .then((value) {
                                  //   Future.delayed(Duration.zero, () async {
                                  //     await Navigator.of(context)
                                  //         .pushNamedAndRemoveUntil(
                                  //       // navigates to homeRoute screen and removes previous routes
                                  //       homeRoute,
                                  //       (route) => false,
                                  //     );
                                  //   });
                                  // });
                                } on FirebaseAuthException catch (_) {
                                  if (mounted) {
                                    setState(() {
                                      _isSomeThingWrong = true;
                                    });
                                  }
                                } finally {
                                  if (_isSomeThingWrong == false) {
                                    Future.delayed(Duration.zero, () async {
                                      await Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        // navigates to homeRoute screen and removes previous routes
                                        homeRoute,
                                        (route) => false,
                                      );
                                    });
                                  }
                                }
                              } on FirebaseAuthException catch (_) {
                                if (mounted) {
                                  setState(() {
                                    _isSomeThingWrong = true;
                                  });
                                }
                              }
                            } else {
                              if (emailController.text == "" ||
                                  !_isValidEmail(emailController.text)) {
                                if (mounted) {
                                  setState(() {
                                    _isEmailValid = false;
                                  });
                                }
                              } else {
                                if (mounted) {
                                  setState(() {
                                    _isEmailValid = true;
                                  });
                                }
                              }
                              if (passwordController.value.text.length < 6) {
                                if (mounted) {
                                  setState(() {
                                    _isPasswordOk = false;
                                  });
                                }
                              } else {
                                if (mounted) {
                                  setState(() {
                                    _isPasswordOk = true;
                                  });
                                }
                              }
                              if (_isPasswordOk && _isEmailValid) {
                                if (mounted) {
                                  setState(() {
                                    _isSomeThingWrong = true;
                                  });
                                }
                              }
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(lightPurple),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          minimumSize:
                              MaterialStateProperty.all(const Size(130, 43)),
                        ),
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Forget password?",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.0,
                                color: primaryPurple,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: lightPurple),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: InkWell(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            await Navigator.of(context).pushNamedAndRemoveUntil(
                              registerRoute,
                              (route) => false,
                            );
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Create new account',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 20, 40, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Flexible(
                            child: Divider(
                              color: Colors.black,
                              thickness: 0.75,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Divider(
                              color: Colors.black,
                              thickness: 0.75,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 50),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: grayDadada),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/icons/google.png',
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
    return Container(color: Colors.white, child: const Text(""));
  }

  bool _isValidEmail(String email) {
    // Validate the email using a regular expression
    final emailRegex = RegExp(r'^[\w.-]+@[\w.-]+\.\w+$');
    return emailRegex.hasMatch(email);
  }
}
