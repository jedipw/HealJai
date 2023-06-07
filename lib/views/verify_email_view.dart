import 'package:flutter/material.dart';
import 'package:healjai/constants/color.dart';
import 'package:healjai/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FocusScopeNode _node = FocusScopeNode();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _checkUserEmailVerification();
    _node.unfocus();
  }

  Future<void> _checkUserEmailVerification() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is already signed in
      if (user.emailVerified) {
        await Navigator.of(context).pushNamedAndRemoveUntil(
          // navigates to homeRoute screen and removes previous routes
          homeRoute,
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Text("Loading...");
    } else {
      return MaterialApp(
        navigatorKey: navigatorKey,
        home: FocusScope(
          node: _node,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 60, 0, 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              // navigates to homeRoute screen and removes previous routes
                              loginRoute,
                              (route) => false,
                            );
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: primaryPurple,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.asset(
                              'assets/icons/mail.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                          const Text(
                            "Verify your",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 40,
                              height: 1.0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "email address",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 40,
                              height: 1.0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "You’ve entered",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "${FirebaseAuth.instance.currentUser!.email}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const Text(
                                " as the",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          const SizedBox(height: 7),
                          const Text("email address for your account.",
                              style: TextStyle(fontSize: 20)),
                          const SizedBox(height: 7),
                          const Text("Please verity this email",
                              style: TextStyle(fontSize: 20)),
                          const SizedBox(height: 7),
                          const Text("address by pressing button below.",
                              style: TextStyle(fontSize: 20)),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 50),
                            child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(lightPurple),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  )),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(300, 45)),
                                  side: MaterialStateProperty.all(
                                      const BorderSide(
                                    color: lightPurple,
                                  )),
                                  overlayColor:
                                      MaterialStateProperty.all(primaryPurple),
                                ),
                                onPressed: () async {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    loginRoute,
                                    (route) => false,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Send email verification",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        height: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
