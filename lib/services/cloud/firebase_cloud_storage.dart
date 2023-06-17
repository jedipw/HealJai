import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healjai/services/cloud/cloud_storage_constants.dart';
import 'package:healjai/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final user = FirebaseFirestore.instance.collection(userCollection);
  final chatMessage =
      FirebaseFirestore.instance.collection(chatMessageCollection);
  final psychiatristProfile =
      FirebaseFirestore.instance.collection(psychiatristProfileCollection);
  final userTagNumber =
      FirebaseFirestore.instance.collection(userTagNumberCollection);

  Future<void> createPsychiatristChatMessage(
      String text, String tagNumber) async {
    try {
      final senderId = FirebaseAuth.instance.currentUser!.uid;

      final getUserTagNumber = await userTagNumber
          .where(userTagNumberField, isEqualTo: tagNumber)
          .get();

      final userId = getUserTagNumber.docs.first.id;

      chatMessage.add(
        {
          isReadField: false,
          sendAtField: DateTime.now(),
          senderIdField: senderId,
          textField: text,
          userIdField: userId,
        },
      );
    } catch (e) {
      log(e.toString());
      throw CouldNotCreateException();
    }
  }
}
