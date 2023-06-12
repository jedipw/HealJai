import 'package:flutter/material.dart';
import 'package:healjai/constants/color.dart';

typedef OnPressedCallBack = Function();

class PaymentStepOne extends StatefulWidget {
  final OnPressedCallBack nextStepOnPressed;
  final OnPressedCallBack packageOneOnPressed;
  final OnPressedCallBack packageTwoOnPressed;
  final OnPressedCallBack packageThreeOnPressed;
  final int packageIndex;

  const PaymentStepOne({
    super.key,
    required this.nextStepOnPressed,
    required this.packageOneOnPressed,
    required this.packageTwoOnPressed,
    required this.packageThreeOnPressed,
    required this.packageIndex,
  });

  @override
  State<PaymentStepOne> createState() => _PaymentStepOneState();
}

class _PaymentStepOneState extends State<PaymentStepOne> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Row(
            children: const [
              Text(
                'STEP 1 OF 2',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 33),
              child: Text(
                'Choose a plan that\'s right for you.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Image.asset('assets/icons/payment_chat.png'),
        const SizedBox(height: 20),
        Column(
          children: [
            Row(
              children: const [
                SizedBox(width: 50),
                Icon(Icons.check, size: 30, color: primaryPurple),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Chat anonymously with licensed and qualified psychiatrists',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 50),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                SizedBox(width: 50),
                Icon(Icons.check, size: 30, color: primaryPurple),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Fast response from psychiatrists',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 50),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                SizedBox(width: 50),
                Icon(Icons.check, size: 30, color: primaryPurple),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'No need for in-person appointments',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 50),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                SizedBox(width: 50),
                Icon(Icons.check, size: 30, color: primaryPurple),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Change or cancel your plan anytime.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 50),
              ],
            ),
            const SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: widget.packageOneOnPressed,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            width: 3,
                            color: widget.packageIndex == 0
                                ? primaryPurple
                                : lightPurple),
                        color: widget.packageIndex == 0
                            ? primaryPurple
                            : Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Daily',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                            height: 1.22,
                            color: widget.packageIndex == 0
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '24 hours',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            height: 1.22,
                            color: widget.packageIndex == 0
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '฿499',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 24.0,
                            height: 31.0 / 26.0,
                            color: widget.packageIndex == 0
                                ? Colors.white
                                : primaryPurple,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: widget.packageTwoOnPressed,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            width: 3,
                            color: widget.packageIndex == 1
                                ? primaryPurple
                                : lightPurple),
                        color: widget.packageIndex == 1
                            ? primaryPurple
                            : Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Weekly',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                            height: 1.22,
                            color: widget.packageIndex == 1
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '7 days',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            height: 1.22,
                            color: widget.packageIndex == 1
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '฿2,999',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 24.0,
                            height: 31.0 / 26.0,
                            color: widget.packageIndex == 1
                                ? Colors.white
                                : primaryPurple,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: widget.packageThreeOnPressed,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            width: 3,
                            color: widget.packageIndex == 2
                                ? primaryPurple
                                : lightPurple),
                        color: widget.packageIndex == 2
                            ? primaryPurple
                            : Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Monthly',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                            height: 1.22,
                            color: widget.packageIndex == 2
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '30 days',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            height: 1.22,
                            color: widget.packageIndex == 2
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '฿9,999',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 24.0,
                            height: 31.0 / 26.0,
                            color: widget.packageIndex == 2
                                ? Colors.white
                                : primaryPurple,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 70),
        Container(
          width: 220,
          height: 50,
          decoration: BoxDecoration(
            color: primaryPurple,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
            onPressed: widget.nextStepOnPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  primaryPurple, // Make the button background transparent
              // Set the text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
