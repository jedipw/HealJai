import 'package:flutter/material.dart';
import 'package:healjai/utilities/heal_talk/heal_talk_psychiatrist_all_chat.dart';
import 'package:healjai/utilities/heal_talk/heal_talk_user.dart';

class HealTalkView extends StatefulWidget {
  const HealTalkView({super.key});

  @override
  State<HealTalkView> createState() => _HealTalkViewState();
}

class _HealTalkViewState extends State<HealTalkView> {
  bool isPsychiatrist = true;

  @override
  Widget build(BuildContext context) {
    return isPsychiatrist ? const HealTalkPsyAllChat() : const HealTalkUser();
  }
}
