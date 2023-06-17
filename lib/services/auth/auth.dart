import 'dart:convert';
import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

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
  bool isDuplicate = await checkIfNumberExists(randomNum.toString());

  while (isDuplicate) {
    randomNum = generateRandomNumber();
    isDuplicate = await checkIfNumberExists(randomNum.toString());
  }

  return randomNum;
}

// Future<bool> checkIfNumberExists(String number) async {
//   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//       .collection('UserTagNumber')
//       .where('userTagNumber', isEqualTo: number)
//       .get();

//   return querySnapshot.docs.isNotEmpty;
// }
Future<bool> checkIfNumberExists(String number) async {
  final url = 'http://4.194.248.57:3000/api/checkIfNumberExists?number=$number';
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Request successful
      return true;
    } else {
      // Request failed
      return false;
    }
  } catch (error) {
    // Error occurred
    print('Error during checkIfNumberExists API request: $error');
    return false;
  }
}

// Future<void> saveUserTagNumber(String userId, String tagNumber) async {
//   await FirebaseFirestore.instance
//       .collection('UserTagNumber')
//       .doc(userId)
//       .set({'userTagNumber': tagNumber});
// }

Future<void> saveUserTagNumber(String userId, String tagNumber) async {
  const url = 'http://4.194.248.57:3000/api/saveUserTagNumber';
  try {
    await http.post(Uri.parse(url), 
    headers: {'Content-Type':'application/json'},
    body: jsonEncode({
      'userId': userId,
      'tagNumber': tagNumber,
    }));
  } catch (error) {
    // Error occurred
    print('Error during saveUserTagNumber API request: $error');
  }
}

// Future<void> saveUserData(String userId) async {
//   await FirebaseFirestore.instance
//       .collection('User')
//       .doc(userId)
//       .set({'isPsychiatrist': false});
// }

Future<void> saveUserData(String userId) async {
  const url = 'http://4.194.248.57:3000/api/saveUserData';
  try {
    await http.post(Uri.parse(url), 
    headers: {'Content-Type':'application/json'},
    body: jsonEncode({
      'userId': userId,
    }));
  } catch (error) {
    // Error occurred
    print('Error during saveUserData API request: $error');
  }
}

Future<bool> register(String email, String password) async {
  String tag = (await getUniqueRandomNumber()).toString();
  try {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    saveUserData(userCredential.user!.uid);
    saveUserTagNumber(userCredential.user!.uid, tag);
    // Registration successful
    return true;
  } on FirebaseAuthException catch (_) {
    // Registration failed
    return false;
  } catch (_) {
    return false;
  }
}
