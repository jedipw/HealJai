import 'package:flutter/material.dart';

class HealTalkView extends StatelessWidget {
  const HealTalkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('HealTalk page'),
            ],
          ),
        ],
      ),
    );
  }
}
