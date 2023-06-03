import 'package:flutter/material.dart';
import '../../constants/color.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isObscure;
  final bool isEmailValid;
  const EmailTextField({
    Key? key,
    required this.controller,
    this.isObscure = false,
    required this.isEmailValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 3),
          // child: Text(
          //   "Email",
          //   style: TextStyle(
          //     fontFamily: 'Poppins',
          //     fontWeight: FontWeight.w500,
          //     fontSize: 17,
          //     height: 1.5,
          //     // color: primaryGray,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
        ),
        TextField(
          controller: controller,
          keyboardType: isEmailValid ? TextInputType.emailAddress : null,
          obscureText: isObscure,
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: grayDadada),
            ),
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: grayDadada),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            hintStyle: TextStyle(color: gray545454),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (!isEmailValid)
                const Text(
                  "Please enter a valid email.",
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Poppins',
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
