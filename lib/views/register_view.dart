import 'package:flutter/material.dart';
import 'package:healjai/constants/routes.dart';
import '../../constants/color.dart';
import '../utilities/custom_text_field/email_text_field.dart';
import '../utilities/custom_text_field/reg_con_password_field.dart';
import '../utilities/custom_text_field/reg_password_field.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:cloud_firestore/cloud_firestore.dart'; // Import FirebaseFirestore
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:flutter_svg/flutter_svg.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  @override
  State<RegisterView> createState() => _RegisterViewState();
}
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Register page'),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamedAndRemoveUntil(
//                   // navigates to homeRoute screen and removes previous routes
//                   loginRoute,
//                   (route) => false,
//                 );
//               },
//               child: const Text('Login'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed(
//                   verifyEmailRoute,
//                 );
//               },
//               child: const Text('Verify Email'),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
// }

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isFnameValid = true;
  bool _isLnameValid = true;
  bool _isEmailValid = true;
  bool _isPasswordOk = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 140, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Create a new account",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20,
                            height: 1.5,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(40, 50, 40, 0),
                    child: Column(
                      children: [
                        // Don't have verification yet
                        EmailTextField(
                            controller: emailController,
                            isEmailValid: _isEmailValid),
                        RegPasswordField(
                          passwordController: passwordController,
                          passwordStat: _isValidPassword(
                              passwordController.text.toString(),
                              confirmPasswordController.text.toString(),
                              "password"),
                          isPasswordOk: _isPasswordOk,
                        ),
                        RegConPasswordField(
                          passwordController: confirmPasswordController,
                          passwordStat: _isValidPassword(
                              confirmPasswordController.text.toString(),
                              passwordController.text.toString(),
                              "confirm password"),
                          isPasswordOk: _isPasswordOk,
                        ),
                        Center(
                          // centers child widget in the screen
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(lightPurple),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(130, 43)),
                            ),
                            onPressed: () async {
                              if (_isEverythingOk(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                confirmPasswordController.text.trim(),
                              )) {
                                try {
                                  FirebaseFirestore firestore =
                                      FirebaseFirestore.instance;
                                  final email = emailController.text.trim();
                                  final password =
                                      passwordController.text.trim();
                                  final userCredential = await FirebaseAuth
                                      .instance
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password)
                                      // await firestore
                                      //     .collection('user')
                                      //     .doc(userCredential.user!.uid)
                                      //     .set({
                                      //       'isPsychiatrist': false,
                                      //     })
                                      .then((value) {})
                                      .catchError((error) {
                                    print(error);
                                  }).then((value) => Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                            // navigates to homeRoute screen and removes previous routes
                                            loginRoute,
                                            (route) => false,
                                          ));
                                } catch (e) {
                                  // showErrorEmailModal(
                                  //   context,
                                  //   () {
                                  //     Navigator.of(context).pop();
                                  //     Navigator.of(context).pop();
                                  //   },
                                  // );
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Register",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Have account text
                        Padding(
                          padding: const EdgeInsets.only(top: 80, bottom: 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                            // navigates to homeRoute screen and removes previous routes
                                            loginRoute,
                                            (route) => false,
                                          );
                                        },
                                        child: const Text(
                                          "Already have an account?",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            height: 1.0,
                                            color: primaryPurple,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 60, 40, 20),
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
                  padding: const EdgeInsets.fromLTRB(40, 5, 40, 50),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: grayDadada),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Handle Google login button tap
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
            ),
          )),
    );
  }

  bool _isValidEmail(String email) {
    // Validate the email using a regular expression
    final emailRegex = RegExp(r'^[\w.-]+@[\w.-]+\.\w+$');
    return emailRegex.hasMatch(email);
  }

  String _isValidPassword(String password1, String password2, String p) {
    if (password1 == "" || password1.isEmpty) {
      return 'Please enter your $p.';
    }
    if (password1.length < 6) {
      return 'Password should be at least 6 characters.';
    }
    if (password1 != password2) {
      return 'Passwords do not match.';
    }
    return "OK";
  }

  bool _isEverythingOk(String email, String password1, String password2) {
    bool isOk = true;
    if (!_isValidEmail(email)) {
      if (mounted) {
        setState(() {
          _isEmailValid = false;
        });
      }
      isOk = false;
    } else {
      if (mounted) {
        setState(() {
          _isEmailValid = true;
        });
      }
    }
    if (_isValidPassword(password1, password2, "") != "OK") {
      if (mounted) {
        setState(() {
          _isPasswordOk = false;
        });
      }
      isOk = false;
    } else {
      if (mounted) {
        setState(() {
          _isPasswordOk = true;
        });
      }
    }
    return isOk;
  }
}
