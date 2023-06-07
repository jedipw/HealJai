import 'package:flutter/material.dart';
import 'package:healjai/constants/color.dart';

typedef OnPressedCallBack = Function();

dynamic showLoadModal(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    barrierColor: Colors.white.withOpacity(0.5),
    builder: (BuildContext context) {
      return Center(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(height: 60),
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(color: primaryPurple),
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      );
    },
  );
}
