import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healjai/services/cloud/cloud_storage_constants.dart';
import 'package:healjai/services/cloud/cloud_storage_exceptions.dart';
import 'package:healjai/utilities/types.dart';
import 'package:intl/intl.dart';

class FirebaseCloudStorage {
  final user = FirebaseFirestore.instance.collection(userCollection);
  final chatMessage =
      FirebaseFirestore.instance.collection(chatMessageCollection);
  final psychiatristProfile =
      FirebaseFirestore.instance.collection(psychiatristProfileCollection);
  final userTagNumber =
      FirebaseFirestore.instance.collection(userTagNumberCollection);

  Future<bool> getIsPsychiatrist() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot documentSnapshot = await user.doc(userId).get();
      return documentSnapshot[isPsychiatristField];
    } catch (e) {
      log(e.toString());
      throw CouldNotGetException();
    }
  }

  Future<void> createUserChatMessage(String text) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      chatMessage.add({
        isReadField: false,
        sendAtField: DateTime.now(),
        senderIdField: userId,
        textField: text,
        userIdField: userId,
      });
    } catch (e) {
      log(e.toString());
      throw CouldNotCreateException();
    }
  }

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

  Future<List<UserChatMessageData>> getUserChat(
      {String tagNumber = '', bool isPsychiatrist = false}) async {
    try {
      String formatDate(Timestamp timestamp) {
        final dateTime = timestamp.toDate();

        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final yesterday = DateTime(now.year, now.month, now.day - 1);

        if (dateTime.year == today.year &&
            dateTime.month == today.month &&
            dateTime.day == today.day) {
          return 'Today';
        } else if (dateTime.year == yesterday.year &&
            dateTime.month == yesterday.month &&
            dateTime.day == yesterday.day) {
          return 'Yesterday';
        } else {
          final formatter = DateFormat('E, d/M');
          return formatter.format(dateTime);
        }
      }

      String userId = '';

      if (tagNumber.isEmpty) {
        userId = FirebaseAuth.instance.currentUser!.uid;
      } else {
        final getUserTagNumber = await userTagNumber
            .where(userTagNumberField, isEqualTo: tagNumber)
            .get();
        userId = getUserTagNumber.docs.first.id;
      }

      final QuerySnapshot<Map<String, dynamic>> chatData = await chatMessage
          .where(userIdField, isEqualTo: userId)
          .orderBy(sendAtField, descending: true)
          .get();

      final numberOfChats = chatData.docs.length; // Get the length of the Map
      final List<UserChatMessageData> userChatMessageData = [];

      for (int i = 0; i < numberOfChats; i++) {
        final data = chatData.docs[i].data();
        final read = data[isReadField];
        final message = data[textField];
        final rawTime = data[sendAtField];
        final dateTime = rawTime.toDate();
        final time = DateFormat.Hm().format(dateTime);
        final date = formatDate(data[sendAtField]);
        final senderUserId = data[senderIdField];
        String profilePic = '';
        String sender = '';

        final currentUserId = FirebaseAuth.instance.currentUser!.uid;
        if (isPsychiatrist) {
          if (senderUserId == userId) {
            sender = 'User';
          } else if (currentUserId == senderUserId) {
            sender = 'UserA';
          } else {
            final QuerySnapshot<Map<String, dynamic>> senderInfo =
                await psychiatristProfile
                    .where(userIdField, isEqualTo: senderUserId)
                    .get();
            final senderData = senderInfo.docs.first.data();
            sender = '${senderData[namePrefixField]} ${senderData[nameField]}';
            profilePic = senderData[pictureURLField];
          }
        } else if (!isPsychiatrist) {
          if (senderUserId == userId) {
            sender = 'UserA';
          } else {
            final QuerySnapshot<Map<String, dynamic>> senderInfo =
                await psychiatristProfile
                    .where(userIdField, isEqualTo: senderUserId)
                    .get();
            final senderData = senderInfo.docs.first.data();
            sender = '${senderData[namePrefixField]} ${senderData[nameField]}';
            profilePic = senderData[pictureURLField];
          }
        }

        userChatMessageData.add(UserChatMessageData(
            message: message,
            sender: sender,
            time: time,
            date: date,
            read: read,
            profilePic: profilePic));

        if ((isPsychiatrist && senderUserId == data[userIdField]) ||
            (!isPsychiatrist && senderUserId != data[userIdField])) {
          final DocumentSnapshot<Map<String, dynamic>> doc =
              await chatMessage.doc(chatData.docs[i].id).get();
          doc.reference.update({
            'isRead': true,
          });
        }
      }

      return userChatMessageData;
    } catch (e) {
      log(e.toString());
      throw CouldNotGetException();
    }
  }

  Future<List<AllChatData>> getAllChat() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      String formatDate(Timestamp timestamp) {
        final dateTime = timestamp.toDate();

        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final yesterday = DateTime(now.year, now.month, now.day - 1);

        if (dateTime.year == today.year &&
            dateTime.month == today.month &&
            dateTime.day == today.day) {
          final formatter = DateFormat.jm();
          return formatter.format(dateTime); // Format: 11:20 PM
        } else if (dateTime.year == yesterday.year &&
            dateTime.month == yesterday.month &&
            dateTime.day == yesterday.day) {
          return 'Yesterday';
        } else if (now.difference(dateTime).inDays <= 7) {
          final formatter = DateFormat('EEEE');
          return formatter.format(dateTime); // Format: Saturday
        } else {
          final formatter = DateFormat('dd/M');
          return formatter.format(dateTime); // Format: 22/5
        }
      }

      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await chatMessage.orderBy(sendAtField, descending: true).get();

      final List<String> userIds = [];

      final List<AllChatData> allChats = [];

      for (final doc in snapshot.docs) {
        final userId = doc[userIdField];
        final senderUserId = doc[senderIdField];
        final isRead = doc[isReadField];
        final time = formatDate(doc[sendAtField]);
        String rawMessage = doc[textField];
        final getUser = await userTagNumber.doc(userId).get();
        final tagNumber = getUser[userTagNumberField];
        final userName = 'User #$tagNumber';
        String sender = '';
        String message = '';

        if (senderUserId == userId) {
          sender = 'User #$tagNumber';
        } else if (senderUserId == currentUserId) {
          sender = 'UserA';
        } else {
          final QuerySnapshot<Map<String, dynamic>> senderInfo =
              await psychiatristProfile
                  .where(userIdField, isEqualTo: senderUserId)
                  .get();
          final senderData = senderInfo.docs.first.data();
          sender = '${senderData[namePrefixField]} ${senderData[nameField]}';
        }

        if (!userIds.contains(userId)) {
          userIds.add(userId);
          if (rawMessage.length > 25 &&
              (sender == userName || senderUserId == currentUserId)) {
            message = '${rawMessage.substring(0, 25)}...';
          } else if (rawMessage.length > 10 && sender != userName) {
            message = '${rawMessage.substring(0, 10)}...';
          } else {
            message = rawMessage;
          }
          allChats.add(AllChatData(
              userName: userName,
              sender: sender,
              message: message,
              time: time,
              isRead: isRead,
              userId: userId));
        }
      }
      return allChats;
    } catch (e) {
      log(e.toString());
      throw CouldNotGetException();
    }
  }
}
