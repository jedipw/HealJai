import 'package:flutter/material.dart';
import 'package:healjai/constants/color.dart';
import 'package:healjai/constants/routes.dart';

class PaymentStepTwo extends StatelessWidget {
  const PaymentStepTwo({super.key});

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
                    'STEP 2 OF 2',
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      width: 200,
                      height: 122,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: primaryPurple,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        'YOUR PLAN',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        'Daily (24 hours)',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        'THB499',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'CHANGE',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: primaryPurple,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 33),
                  child: Text(
                    'Set up your credit or debit card.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            /*Row(children: [
              Image.asset(
                'assets/images/mastercard.png', 
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ]),*/
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 7),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Color(0xFFDADADA)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Color(0xFFDADADA)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: primaryPurple),
                      ),
                      hintText: 'First Name',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xFF545454),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 7),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Color(0xFFDADADA)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Color(0xFFDADADA)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: primaryPurple),
                      ),
                      hintText: 'Last Name',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xFF545454),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 7),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Color(0xFFDADADA)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Color(0xFFDADADA)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: primaryPurple),
                      ),
                      hintText: 'Card Number',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xFF545454),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 7),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Color(0xFFDADADA)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Color(0xFFDADADA)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: primaryPurple),
                      ),
                      hintText: 'Expiry Date (MM/YY)',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xFF545454),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 7),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Color(0xFFDADADA)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Color(0xFFDADADA)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: primaryPurple),
                      ),
                      hintText: 'Security (CVV)',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xFF545454),
                      ),
                    ),
                  ),
                ),
              ],
            ),
           const SizedBox(height: 10),
            Container(
              width: 220,
              height: 50,
              decoration: BoxDecoration(
                color: primaryPurple,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    healTalkRoute,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      primaryPurple, // Make the button background transparent
                  // Set the text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Start Membership',
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