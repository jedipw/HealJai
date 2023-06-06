import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healjai/services/cloud/cloud_storage_constants.dart';
import 'package:healjai/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final user = FirebaseFirestore.instance.collection(userCollection);
  final chatMessage =
      FirebaseFirestore.instance.collection(chatMessageCollection);

  Future<bool> getIsPsychiatrist() async {
    try {
      const userId = 'MSaytbm2Y3jYa6BzpHUu';
      DocumentSnapshot documentSnapshot = await user.doc(userId).get();
      return documentSnapshot[isPsychiatristField];
    } catch (e) {
      log(e.toString());
      throw CouldNotGetException();
    }
  }

  Future<void> createUserChatMessage(String text) async {
    try {
      const userId = 'MSaytbm2Y3jYa6BzpHUu';
      chatMessage.add({
        isReadField: false,
        sendAtField: DateTime.now(),
        senderIdField: userId,
        textField: text,
        userId: userId,
      });
    } catch (e) {
      log(e.toString());
      throw CouldNotCreateException();
    }
  }

  Future<void> createPsychiatristChatMessage(String text, String userId) async {
    try {
      const senderId = 'MSaytbm2Y3jYa6BzpHUu';
      chatMessage.add({
        isReadField: false,
        sendAtField: DateTime.now(),
        senderIdField: senderId,
        textField: text,
        userId: userId,
      });
    } catch (e) {
      log(e.toString());
      throw CouldNotCreateException();
    }
  }
}
