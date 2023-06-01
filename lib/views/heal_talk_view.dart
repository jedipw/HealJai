import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healjai/constants/color.dart';

class HealTalkView extends StatefulWidget {
  const HealTalkView({super.key});

  @override
  State<HealTalkView> createState() => _HealTalkViewState();
}

class _HealTalkViewState extends State<HealTalkView> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  List<Map<String, dynamic>> messages = [
    {
      'message':
          'Thank you for sharing that with me. It takes courage to open up about your struggles. It\'s important to remember that you don\'t have to go through this alone. Many people experience similar feelings of wearing a mask and hiding their true emotions. I\'m here to provide a safe and nonjudgmental space where we can explore what you\'re going through. Together, we can work towards understanding your struggles and finding healthier ways to cope. Is there anything specific you would like to discuss or any areas you feel comfortable starting with?',
      'sender': 'Dr. Wararattana',
      'time': '11:05',
      'date': 'Fri, 26/5',
      'read': true,
      'profilePic':
          'https://th.bing.com/th/id/R.58f60f6b81ae6d054b6b4910a9771fbf?rik=%2fKjN%2fqPR7wXaUw&pid=ImgRaw&r=0',
    },
    {
      'message':
          'I didn\'t expect anyone to notice, but it\'s been tough. I feel like I\'m constantly wearing a mask, pretending everything is okay. But inside, I\'m really struggling.',
      'sender': 'UserA',
      'time': '11:00',
      'date': 'Fri, 26/5',
      'read': true,
    },
    {
      'message':
          'Hello, I\'m here to support you. It seems like you\'re feeling sad. Is there something specific on your mind that you\'d like to talk about today? Remember, I\'m here to listen and help you navigate through any challenges you may be facing.',
      'sender': 'Dr. Wararattana',
      'time': '11:05',
      'date': 'Thu, 25/5',
      'read': true,
      'profilePic':
          'https://th.bing.com/th/id/R.58f60f6b81ae6d054b6b4910a9771fbf?rik=%2fKjN%2fqPR7wXaUw&pid=ImgRaw&r=0',
    },
    {
      'message': 'Hello 🥲🥲🥲',
      'sender': 'UserA',
      'time': '11:00',
      'date': 'Thu, 25/5',
      'read': true,
    },
    // Add more messages with profile pictures
  ];

  TextEditingController textController = TextEditingController();

  final TextInputFormatter noLeadingSpaceFormatter =
      FilteringTextInputFormatter.deny(RegExp(r'^\s'));

  bool canSend = false;

  @override
  void dispose() {
    // Dispose the ScrollController when it's no longer needed
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Scroll to the bottom after the widget has been built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
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
      body: GestureDetector(
        behavior: HitTestBehavior
            .opaque, // Ensure the GestureDetector handles the tap event
        onTap: () {
          // Unfocus the TextField when tapped outside of it
          _focusNode.unfocus();
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final message = messages[index]['message'];
                  final sender = messages[index]['sender'];
                  final time = messages[index]['time'];
                  final date = messages[index]['date'];
                  final isMessageRead = messages[index]['read'];
                  final profilePic = messages[index]['profilePic'];
                  final isUserMessage = sender ==
                      'UserA'; // Replace 'UserA' with the user's actual name or ID

                  bool shouldDisplayDate = index == messages.length - 1 ||
                      date != messages[index + 1]['date'];

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
                                    padding: const EdgeInsets.only(left: 10.0),
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
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
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
                                                      const Radius.circular(30),
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
                            flex: 4,
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
                                            16.0, 3.0, 8.0, 11.0)
                                        : const EdgeInsets.fromLTRB(
                                            16.0, 3.0, 12.0, 3.0),
                                    child: TextField(
                                      focusNode: _focusNode,
                                      onChanged: (value) {
                                        setState(() {
                                          if (textController.text.isNotEmpty) {
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
                                          height: 27.0 /
                                              16.0, // Calculating line height from font size and line height ratio
                                        ),
                                      ),
                                      maxLines: null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: canSend
                                    ? TextButton(
                                        onPressed: () {
                                          sendMessage();
                                        },
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
                                      )
                                    : const SizedBox(),
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
        ),
      ),
    );
  }

  void sendMessage() {
    _scrollToBottom();
    setState(() {
      canSend = false;
      String message = textController.text;
      textController.clear();
      String currentUser =
          'UserA'; // Replace 'UserA' with the user's actual name or ID
      DateTime currentTime = DateTime.now();
      String formattedTime =
          formatTime(currentTime); // Format the time as 'h:mm a'
      String currentDate = DateTime.now()
          .toString()
          .substring(0, 10); // Get the current date in 'yyyy-MM-dd' format
      String formattedDate =
          formatDate(currentDate); // Format the date as 'E, M/d'

      messages.insert(
        0,
        {
          'message': message,
          'sender': currentUser,
          'time': formattedTime,
          'date': formattedDate,
          'read': false,
        },
      ); // Add the new message at the beginning of the list
    });
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
