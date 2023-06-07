import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> login(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true; // Return true for successful login
  } on FirebaseAuthException catch (_) {
    return false; // Return false for login failure
  } catch (_) {
    return false; // Return false for login failure
  }
}

Future<void> logout() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (_) {}
}

int generateRandomNumber() {
  Random random = Random();
  return random.nextInt(90000000) +
      10000000; // Generate a random number between 10000000 and 99999999
}

Future<int> getUniqueRandomNumber() async {
  int randomNum = generateRandomNumber();
  bool isDuplicate = await checkIfNumberExists(randomNum);

  while (isDuplicate) {
    randomNum = generateRandomNumber();
    isDuplicate = await checkIfNumberExists(randomNum);
  }

  return randomNum;
}

Future<bool> checkIfNumberExists(int number) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('UserTagNumber')
      .where('userTagNumber', isEqualTo: number)
      .get();

  return querySnapshot.docs.isNotEmpty;
}

Future<void> saveUserTagNumber(String userId, int tagNumber) async {
  await FirebaseFirestore.instance
      .collection('UserTagNumber')
      .doc(userId)
      .set({'userTagNumber': tagNumber});
}

Future<void> saveUserData(String userId) async {
  await FirebaseFirestore.instance
      .collection('User')
      .doc(userId)
      .set({'isPsychiatrist': false});
}
