import 'package:flutter/material.dart';
import 'package:healjai/constants/routes.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

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
              const Text('Payment page'),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    healTalkRoute,
                  );
                },
                child: const Text('HealTalk'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
