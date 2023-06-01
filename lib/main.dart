import 'package:flutter/material.dart';
import 'package:healjai/constants/routes.dart';
import 'package:healjai/utilities/page_route.dart';
import 'package:healjai/views/heal_talk_view.dart';
import 'package:healjai/views/home_view.dart';
import 'package:healjai/views/login_view.dart';
import 'package:healjai/views/payment_view.dart';
import 'package:healjai/views/register_view.dart';
import 'package:healjai/views/verify_email_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Setting the initial route for the app
      initialRoute: loginRoute,
      // Generating routes for each screen/view in the app
      onGenerateRoute: (settings) {
        switch (settings.name) {
          // Routing for the LoginView screen
          case loginRoute:
            return HealJaiPageRoute(
                builder: (_) => const LoginView(), settings: settings);

          // Routing for the HomeView screen
          case homeRoute:
            return HealJaiPageRoute(
                builder: (_) => const HomeView(), settings: settings);

          // Routing for the RegisterView screen
          case registerRoute:
            return HealJaiPageRoute(
                builder: (_) => const RegisterView(), settings: settings);

          // Routing for the VerifyEmailView screen
          case verifyEmailRoute:
            return HealJaiPageRoute(
                builder: (_) => const VerifyEmailView(), settings: settings);

          // Routing for the HealTalkScreen screen
          case healTalkRoute:
            return HealJaiPageRoute(
                builder: (_) => const HealTalkView(), settings: settings);

          // Routing for the VerifyEmailView screen
          case paymentRoute:
            return HealJaiPageRoute(
                builder: (_) => const PaymentView(), settings: settings);

          // Return null for any unknown routes
          default:
            return null;
        }
      },
    );
  }
}
