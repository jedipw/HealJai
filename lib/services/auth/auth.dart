import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../../constants/routes.dart';

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

Future<bool> checkIfNumberExists(String number) async {
  final url = '$defaultURL/api/checkIfNumberExists?number=$number';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Request successful
      dynamic jsonData = json.decode(response.body);
      bool numberExists = jsonData['exists'] ??
          false; // Extract the 'exists' field from the response
      return numberExists;
    } else {
      // Request failed
      return true;
    }
  } catch (_) {
    // Error occurred
    return true;
  }
}

Future<void> saveUserTagNumber(String userId, String tagNumber) async {
  const url = '$defaultURL/api/saveUserTagNumber';
  try {
    await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'tagNumber': tagNumber,
        }));
  } catch (_) {
    // Error occurred
  }
}

Future<void> saveUserData(String userId) async {
  const url = '$defaultURL/api/saveUserData';
  try {
    await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
        }));
  } catch (_) {
    // Error occurred
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
