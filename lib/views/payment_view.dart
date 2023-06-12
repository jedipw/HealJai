import 'package:flutter/material.dart';
import 'package:healjai/utilities/payment/step_one.dart';
import 'package:healjai/utilities/payment/step_two.dart';

import '../constants/color.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  bool _isFirstStep = true;
  int _packageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(71.0),
        child: GestureDetector(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: grayDadada,
                  width: 1.0,
                ),
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: primaryPurple,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'HealTalk',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: primaryPurple,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: _isFirstStep
            ? PaymentStepOne(
                nextStepOnPressed: () {
                  setState(() {
                    _isFirstStep = false;
                  });
                },
                packageOneOnPressed: () {
                  setState(() {
                    _packageIndex = 0;
                  });
                },
                packageTwoOnPressed: () {
                  setState(() {
                    _packageIndex = 1;
                  });
                },
                packageThreeOnPressed: () {
                  setState(() {
                    _packageIndex = 2;
                  });
                },
                packageIndex: _packageIndex,
              )
            : const PaymentStepTwo(),
      ),
    );
  }
}

/*class CreditcardDetails extends StatefulWidget {
  const CreditcardDetails({super.key});

  @override
  State<CreditcardDetails> createState() => _CreditcardDetailsState();
}

class _CreditcardDetailsState extends State<CreditcardDetails> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}*/
