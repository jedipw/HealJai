import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healjai/constants/color.dart';
import 'package:healjai/services/cloud/firebase_cloud_storage.dart';
import 'package:healjai/utilities/heal_talk/heal_talk_psychiatrist_all_chat.dart';
import 'package:healjai/utilities/heal_talk/heal_talk_user.dart';

class HealTalkView extends StatefulWidget {
  const HealTalkView({super.key});

  @override
  State<HealTalkView> createState() => _HealTalkViewState();
}

class _HealTalkViewState extends State<HealTalkView> {
  bool _isPsychiatrist = false;
  bool _isRoleLoaded = false;

  @override
  void initState() {
    super.initState();
    _getIsPsychiatristData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getIsPsychiatristData();
  }

  Future<void> _getIsPsychiatristData() async {
    try {
      bool userData = await FirebaseCloudStorage().getIsPsychiatrist();
      bool userHasRole = userData;

      // Update the state
      if (mounted) {
        setState(
          () {
            _isPsychiatrist = userHasRole;
            _isRoleLoaded = true;
          },
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isRoleLoaded
        ? _isPsychiatrist
            ? const HealTalkPsyAllChat()
            : const HealTalkUser()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(71.0),
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
                      alignment: Alignment.centerLeft, // Align text to the left
                      child: Text(
                        'HealTalk', // Add the word "HealTalk" here
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(color: primaryPurple),
                  ],
                ),
              ],
            ),
          );
  }
}
