import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healjai/constants/color.dart';
import 'package:healjai/constants/routes.dart';
import 'package:healjai/utilities/types.dart';
import 'package:http/http.dart' as http;
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HealTalkUser extends StatefulWidget {
  const HealTalkUser({super.key});

  @override
  State<HealTalkUser> createState() => _HealTalkUserState();
}

class _HealTalkUserState extends State<HealTalkUser> {
  late IO.Socket _socket;
  final ScrollController _scrollController = ScrollController();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = true;

  _connectSocket() {
    _socket.onConnect((data) => log('Connection established'));
    _socket.onConnectError((data) => log('Connect Error: $data'));
    _socket.onDisconnect((data) => log('Socket.IO server disconnected'));
    _socket.on('userMessage', (data) => getChatData('user'));
    _socket.on('psycMessage', (data) => getChatData('psyc'));
    _socket.on('readMessage', (data) => getChatData('read'));
  }

  final FocusNode _focusNode = FocusNode();
  bool isSending = false;

  List<UserChatMessageData> messages = [];

  TextEditingController textController = TextEditingController();

  final TextInputFormatter noLeadingSpaceFormatter =
      FilteringTextInputFormatter.deny(RegExp(r'^\s'));

  bool canSend = false;

  @override
  void dispose() {
    // Dispose the ScrollController when it's no longer needed
    _scrollController.dispose();
    _focusNode.dispose();
    _socket.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _socket = IO.io(
        defaultURL,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    _connectSocket();
    _socket.connect();
    getChatData('psyc');
  }

  Future<void> getChatData(String mode) async {
    String apiUrl = '$defaultURL/api/getUserChat';
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // Construct the query parameters
    Map<String, dynamic> queryParams = {
      'tagNumber': '',
      'isPsychiatrist': false.toString(),
      'currentUserId': currentUserId,
    };

    // Construct the API URL with query parameters
    Uri url = Uri.parse(apiUrl).replace(queryParameters: queryParams);
    try {
      // Make the HTTP GET request
      final response = await http.get(url);
      // Successful response
      List<UserChatMessageData> chatData = [];

      // Parse the response body into a list of UserChatMessageData objects
      List<dynamic> responseData = json.decode(response.body);
      for (var data in responseData) {
        UserChatMessageData chatMessage = UserChatMessageData(
          date: data['date'],
          message: data['message'],
          profilePic: data['profilePic'],
          read: data['read'],
          sender: data['sender'],
          time: data['time'],
        );
        chatData.add(chatMessage);
      }

      setState(() {
        messages = chatData;
        isLoading = false;
      });
      if (mode == 'psyc') {
        _socket.emit('readMessage', {});
      }
    } catch (e) {
      log(e.toString());
      // Handle error or break the stream if necessary
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(71.0),
          child: GestureDetector(
            behavior: HitTestBehavior
                .opaque, // Ensure the GestureDetector handles the tap event
            onTap: () {
              // Unfocus the TextField when tapped outside of it
              _focusNode.unfocus();
            },
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
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior
                    .opaque, // Ensure the GestureDetector handles the tap event
                onTap: () {
                  // Unfocus the TextField when tapped outside of it
                  _focusNode.unfocus();
                },
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final message = messages[index].message;
                    final sender = messages[index].sender;
                    final time = messages[index].time;
                    final date = messages[index].date;
                    final isMessageRead = messages[index].read;
                    final profilePic = messages[index].profilePic;
                    final isUserMessage = sender == 'You';

                    bool shouldDisplayDate = index == messages.length - 1 ||
                        date != messages[index + 1].date;

                    List<Widget> children = [];

                    children.add(
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: isUserMessage
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            if (shouldDisplayDate)
                              Center(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    date,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      height: 21 / 14,
                                      color: Color.fromRGBO(0, 0, 0, 0.75),
                                    ),
                                  ),
                                ),
                              ),
                            if (shouldDisplayDate) const SizedBox(height: 8.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: isUserMessage
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                if (!isUserMessage)
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(profilePic),
                                    radius: 16,
                                    backgroundColor: primaryPurple,
                                  ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    isUserMessage
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, bottom: 5.0),
                                            child: Text(
                                              sender,
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                height: 18.0 /
                                                    14.0, // Calculating line height from font size and line height ratio
                                              ),
                                            ),
                                          ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Wrap(
                                        alignment: isUserMessage
                                            ? WrapAlignment.end
                                            : WrapAlignment.start,
                                        crossAxisAlignment: WrapCrossAlignment
                                            .end, // Align the profile picture to the bottom right
                                        children: <Widget>[
                                          if (isUserMessage)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                if (isUserMessage &&
                                                    isMessageRead) // Display "READ" if the message is read
                                                  const Text(
                                                    'Read',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11.0,
                                                      height: 15.0 /
                                                          11.0, // Calculating line height from font size and line height ratio
                                                    ),
                                                  ),
                                                Text(
                                                  time,
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11.0,
                                                    height: 15.0 /
                                                        11.0, // Calculating line height from font size and line height ratio
                                                  ),
                                                ),
                                              ],
                                            ),
                                          isUserMessage
                                              ? const SizedBox(width: 6.0)
                                              : Container(),
                                          Container(
                                            padding: const EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: isUserMessage
                                                      ? lightPurple
                                                      : primaryPurple,
                                                  width: 2.0,
                                                ),
                                                color: isUserMessage
                                                    ? lightPurple
                                                    : Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: isUserMessage
                                                        ? const Radius.circular(
                                                            30)
                                                        : const Radius.circular(
                                                            0),
                                                    topRight: !isUserMessage
                                                        ? const Radius.circular(
                                                            30)
                                                        : const Radius.circular(
                                                            0),
                                                    bottomLeft:
                                                        const Radius.circular(
                                                            30),
                                                    bottomRight:
                                                        const Radius.circular(
                                                            30))),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.55, // Set the maximum width to 75% of the screen width
                                              ),
                                              child: Text(
                                                message,
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    height: 21 / 14,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          if (!isUserMessage)
                                            Text(
                                              time,
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.0,
                                                height: 15.0 /
                                                    11.0, // Calculating line height from font size and line height ratio
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                          ],
                        ),
                      ),
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: children.reversed.toList(),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: grayDadada,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: grayEbebeb,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return Container(
                                    constraints: const BoxConstraints(
                                      maxHeight:
                                          200, // Set the maximum height for the container
                                    ),
                                    padding: textController.text.isNotEmpty &&
                                            textController.text
                                                    .split('\n')
                                                    .length >
                                                1
                                        ? const EdgeInsets.fromLTRB(
                                            16.0, 6.0, 8.0, 12.0)
                                        : const EdgeInsets.fromLTRB(
                                            16.0, 6.0, 12.0, 9.0),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(_focusNode);
                                      },
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                130,
                                            child: TextField(
                                              focusNode: _focusNode,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (textController
                                                      .text.isNotEmpty) {
                                                    canSend = true;
                                                  } else {
                                                    canSend = false;
                                                  }
                                                });
                                              },
                                              inputFormatters: [
                                                noLeadingSpaceFormatter
                                              ],
                                              cursorColor: darkPurple,
                                              controller: textController,
                                              decoration: const InputDecoration(
                                                hintText: 'Message...',
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.zero,
                                                hintStyle: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.0,
                                                  height: 27.0 / 16.0,
                                                ),
                                              ),
                                              maxLines: null,
                                            ),
                                          ),
                                          Visibility(
                                            visible: canSend,
                                            child: Positioned(
                                              bottom: 0.0,
                                              right: 0.0,
                                              child: TextButton(
                                                onPressed: sendChatMessage,
                                                child: const Text(
                                                  'SEND',
                                                  style: TextStyle(
                                                    color: primaryPurple,
                                                    fontFamily: 'Poppins',
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isSending,
                                            child: Positioned(
                                              bottom: 0.0,
                                              right: 0.0,
                                              child: TextButton(
                                                onPressed: sendChatMessage,
                                                child: const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: primaryPurple,
                                                          strokeWidth: 2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> sendChatMessage() async {
    try {
      _scrollToBottom();
      String message = textController.text.trim();
      setState(() {
        isSending = true;
        canSend = false;
      });

      const url =
          '$defaultURL/api/createUserChatMessage'; // Replace with your actual backend URL

      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'userId': userId,
            'text': message,
          }));

      if (response.statusCode == 200) {
        // Message sent successfully
        log('Message sent successfully');
        setState(() {
          isSending = false;
          textController.clear();
          _socket.emit('userMessage', {});
        });
      } else {
        // Failed to send message
        log('Failed to send message');
      }
    } catch (error) {
      log('Error sending message: $error');
    }
  }

  String formatTime(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = parsedDate.weekday == DateTime.now().weekday
        ? 'Today'
        : '${weekdayAbbreviation(parsedDate.weekday)}, ${parsedDate.month}/${parsedDate.day}';
    return formattedDate;
  }

  String weekdayAbbreviation(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
