import 'package:flutter/material.dart';
import '../../constants/color.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required this.passwordController,
    required this.isPasswordOk,
    this.text = 'Password',
  }) : super(key: key);

  final TextEditingController passwordController;
  final bool isPasswordOk;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          child: TextField(
            controller: passwordController,
            style: const TextStyle(
              fontFamily: 'Poppins',
            ),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: primaryPurple),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: grayDadada),
              ),
              hintText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: grayDadada),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              hintStyle: TextStyle(color: gray545454),
              filled: true,
              fillColor: Colors.white,
            ),
            obscureText: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (!isPasswordOk)
                const Text(
                  "Please enter the correct password.",
                  style: TextStyle(color: Colors.red, fontFamily: 'Poppins'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
