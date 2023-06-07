import 'package:flutter/material.dart';
import 'package:healjai/constants/routes.dart';
import 'package:healjai/services/auth/auth_backend_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Home page'),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    // navigates to homeRoute screen and removes previous routes
                    paymentRoute,
                  );
                },
                child: const Text('Payment'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    // navigates to homeRoute screen and removes previous routes
                    loginRoute,
                    (route) => false,
                  );
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  logout().then((value) =>  Navigator.of(context).pushNamedAndRemoveUntil(
                    // navigates to homeRoute screen and removes previous routes
                    loginRoute,
                    (route) => false,
                  ));
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
