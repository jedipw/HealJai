import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healjai/constants/color.dart';
import 'package:healjai/utilities/heal_talk/heal_talk_psychiatrist_chat.dart';
import 'package:healjai/utilities/types.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HealTalkPsyAllChat extends StatefulWidget {
  const HealTalkPsyAllChat({super.key});

  @override
  State<HealTalkPsyAllChat> createState() => _HealTalkPsyAllChatState();
}

class _HealTalkPsyAllChatState extends State<HealTalkPsyAllChat> {
  List<AllChatData> chats = [];
  late IO.Socket _socketAllChat;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _socketAllChat = IO.io(
        'http://4.194.248.57:3000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    _connectSocket();
    _socketAllChat.connect();
    getAllChatsData();
  }

  _connectSocket() {
    _socketAllChat.onConnect((data) => log('Connection established'));
    _socketAllChat.onConnectError((data) => log('Connect Error: $data'));
    _socketAllChat.onDisconnect((data) => log('Socket.IO server disconnected'));
    _socketAllChat.on('userMessage', (data) => getAllChatsData());
    _socketAllChat.on('psycMessage', (data) => getAllChatsData());
    _socketAllChat.on('readMessage', (data) => getAllChatsData());
  }

  Future<void> getAllChatsData() async {
    const apiUrl = 'http://4.194.248.57:3000/api/getAllChat';
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // Construct the query parameters
    final queryParams = {
      'currentUserId': currentUserId,
    };

    // Construct the API URL with query parameters
    final url = Uri.parse(apiUrl).replace(queryParameters: queryParams);
    try {
      // Make the HTTP GET request
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Successful response
        final responseData = json.decode(response.body) as List<dynamic>;

        // Parse the response body into a list of AllChatData objects
        final allChatData = responseData.map((data) {
          return AllChatData(
            userName: data['userName'],
            sender: data['sender'],
            message: data['message'],
            time: data['time'],
            isRead: data['isRead'],
            userId: data['userId'],
          );
        }).toList();
        setState(() {
          chats = allChatData;
          isLoading = false;
        });
      } else {
        // Error handling
        throw Exception('Failed to get all chat data');
      }
    } catch (e) {
      log(e.toString());
      // Handle error or break the stream if necessary
    }
  }

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
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryPurple,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
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
                                borderRadius:
                                    BorderRadius.circular(25), // Border radius
                              ),
                              child: const TextField(
                                enabled: false,
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
                                  prefixIcon: Icon(Icons.search,
                                      color: grayBdbdbd, size: 30),
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
                                _socketAllChat.dispose();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HealTalkPsyChat(
                                      userName: chats[index].userName,
                                    ),
                                  ),
                                ).then((_) {
                                  _socketAllChat = IO.io(
                                      'http://4.194.248.57:3000',
                                      IO.OptionBuilder()
                                          .setTransports(['websocket'])
                                          .disableAutoConnect()
                                          .build());
                                  _connectSocket();
                                  getAllChatsData();
                                  _socketAllChat.connect();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: (chats.length > index &&
                                            (chats[index].isRead ||
                                                chats[index].sender == 'You'))
                                        ? Colors.grey.shade400
                                        : Colors.deepPurple,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(24),
                                  ),
                                ),
                                margin: const EdgeInsets.only(top: 20.0),
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 20.0, 15.0, 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          chats.length > index
                                              ? chats[index].userName
                                              : '',
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
                                          chats.length > index
                                              ? chats[index].time
                                              : '',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Row(
                                            children: [
                                              Visibility(
                                                visible: chats.length > index &&
                                                    chats[index].userName !=
                                                        chats[index].sender &&
                                                    chats[index].sender !=
                                                        'You',
                                                child: Text(
                                                  chats.length > index
                                                      ? '${chats[index].sender}: '
                                                      : '',
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
                                                visible: chats.length > index &&
                                                    chats[index].sender ==
                                                        'You',
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
                                                chats.length > index
                                                    ? chats[index].message
                                                    : '',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: chats.length >
                                                              index &&
                                                          chats[index].isRead &&
                                                          chats[index].sender !=
                                                              'You'
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
                                          visible: chats.length > index
                                              ? !chats[index].isRead &&
                                                  chats[index].sender != 'You'
                                              : false,
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
              ));
  }
}
