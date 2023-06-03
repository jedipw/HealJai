import 'package:flutter/material.dart';
import 'package:healjai/constants/color.dart';
import 'package:healjai/utilities/heal_talk/heal_talk_psychiatrist_chat.dart';

class HealTalkPsyAllChat extends StatefulWidget {
  const HealTalkPsyAllChat({super.key});

  @override
  State<HealTalkPsyAllChat> createState() => _HealTalkPsyAllChatState();
}

class _HealTalkPsyAllChatState extends State<HealTalkPsyAllChat> {
  List<Map<String, dynamic>> chats = [
    {
      'userName': 'User #12315678',
      'sender': 'User #12315678',
      'message': 'I\'m very sad. My code are not workin...',
      'time': '11:20 PM',
      'isRead': false,
    },
    {
      'userName': 'User #12325678',
      'sender': 'UserA',
      'message': 'Don\'t give up',
      'time': '11:18 PM',
      'isRead': true,
    },
    {
      'userName': 'User #12335678',
      'sender': 'User #12335678',
      'message': 'I\'ve just broken up with my girlfrien...',
      'time': '10:59 PM',
      'isRead': false,
    },
    {
      'userName': 'User #12345678',
      'sender': 'User #12345678',
      'message': 'I am so tired :(',
      'time': '10:55 PM',
      'isRead': true,
    },
    {
      'userName': 'User #12345378',
      'sender': 'Dr.Witthaya',
      'message': 'You should exercises m...',
      'time': 'Yesterday',
      'isRead': true,
    },
    {
      'userName': 'User #12335378',
      'sender': 'Dr.Pornpimon',
      'message': 'I understand you and...',
      'time': 'Saturday',
      'isRead': true,
    },
    {
      'userName': 'User #12335658',
      'sender': 'User #12335658',
      'message': 'Hello',
      'time': '22/5',
      'isRead': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: grayBdbdbd,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(25), // Border radius
                    ),
                    child: const TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          height: 27 /
                              18, // Adjust line height as needed (line height = font size * line height factor)
                          color: gray545454,
                        ),
                        border: InputBorder.none, // Remove underline
                        prefixIcon:
                            Icon(Icons.search, color: grayBdbdbd, size: 30),
                      ),
                      // TextField properties...
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 15.0),
              height: MediaQuery.of(context).size.height - 234,
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HealTalkPsyChat(
                            userName: chats[index]['userName'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              chats[index]['isRead'] ? grayBdbdbd : darkPurple,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(24),
                        ),
                      ),
                      margin: const EdgeInsets.only(top: 20.0),
                      padding:
                          const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                chats[index]['userName'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  height:
                                      1.47, // Adjust line height as needed (line height = font size * line height factor)
                                  color: darkPurple,
                                ),
                              ),
                              Text(
                                chats[index]['time'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  height:
                                      1.5, // Adjust line height as needed (line height = font size * line height factor)
                                  color: Color.fromRGBO(0, 0, 0,
                                      0.75), // Black color with 0.75 opacity
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  children: [
                                    Visibility(
                                      visible: chats[index]['userName'] !=
                                              chats[index]['sender'] &&
                                          chats[index]['sender'] != 'UserA',
                                      child: Text(
                                        '${chats[index]['sender']}: ',
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          height:
                                              1.5, // Adjust line height as needed (line height = font size * line height factor)
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          chats[index]['sender'] == 'UserA',
                                      child: const Text(
                                        'You: ',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          height:
                                              1.5, // Adjust line height as needed (line height = font size * line height factor)
                                        ),
                                      ),
                                    ),
                                    Text(
                                      chats[index]['message'],
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: chats[index]['isRead']
                                            ? FontWeight.w400
                                            : FontWeight.w500,
                                        fontSize: 14,
                                        height:
                                            1.5, // Adjust line height as needed (line height = font size * line height factor)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: !chats[index]['isRead'],
                                child: const CircleAvatar(
                                  maxRadius: 7,
                                  backgroundColor: lightPurple,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}