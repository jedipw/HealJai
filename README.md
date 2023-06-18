# HealJai
Consult with psychiatrists anywhere, anytime, and anonymously.

**IMPORTANT:** Please read this before starting to run the project's code.

**Table of Contents**
1. About the implementation of the project
2. First time setup
3. Developer's recommendation
4. Psychiatrist's accounts
5. Developer's contact
## 1. About the implementation of the project
This project is partially functional; not everything is working here. Here is a list of the functions that are currently functional:
1. Authentication (Register, Login, and Log out)
2. HealTalk (Chat with other psychiatrists)

Additionally, the following functions are functional only for the screen:
1. Home page
2. Payment
3. Verify Email

## 2. First time setup
### A.) Normal setup:
1. Run `flutter pub get` in terminal
2. If you use your own machine to run the backend server, you need to modify the "defaultURL" to "http://localhost:3000".  
   (Note: Don't forget to run the backend first; see the installation manual in README.md of backend-HealJai.)
3. Select device that you want to run
4. Select run without debugging

### B.) Developer setup:
##### Update dart:
1. Run `choco upgrade dart` in terminal
2. Run `flutter channel stable` in terminal
3. Run `flutter upgrade` in terminal
##### Connect to firebase (need to contact us):
1. Run `flutter pub upgrade firebase_core` in terminal
2. Run `dart pub global activate flutterfire_cli` in terminal
3. Run `flutterfire configure` in terminal
##### Set up the path to the backend(choose one method):
- Contact us to use our Microsoft Virtual Machine for server hosting.
- Use your own machine to run the backend server and modify the "defaultURL" to "http://localhost:3000".  
   (Note: Don't forget to run the backend first; see the installation manual in README.md of backend-HealJai.)

## 3. Developer's recommendation
Try not to run our code on a browser since we developed our project for mobile applications. Therefore, if you use it in a browser, the text fonts and interface may not be the same as the application on mobile.

## 4. Psychiatrist's accounts
There are two psychiatrist accounts provided for you.
1. **Dr. Wararattana Wara**<br />
   **Email:** staff1@email.com<br />
   **Password:** 12345678

2. **Dr. Pornpimon Kusonbhun**<br />
   **Email:** staff2@email.com<br />
   **Password:** 12345678


## 5. Developer's contact
If there are any questions or problems, please contact us via 2/2565_CSC291 Integrated Proj on channel g01_1510 of the Microsoft Teams channel.