import 'package:flutter/material.dart';
import '../../constants/color.dart';

class RegPasswordField extends StatelessWidget {
  const RegPasswordField({
    Key? key,
    required this.passwordController,
    required this.passwordStat,
    required this.isPasswordOk,
    this.text = 'Password',
  }) : super(key: key);

  final TextEditingController passwordController;
  final String passwordStat;
  final bool isPasswordOk;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          cursorColor: darkPurple,
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (!isPasswordOk && passwordStat != "OK")
                Text(
                  passwordStat,
                  style:
                      const TextStyle(color: Colors.red, fontFamily: 'Poppins'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
