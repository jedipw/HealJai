class UserChatMessageData {
  final String message;
  final String sender;
  final String time;
  final String date;
  final bool read;
  final String profilePic;

  UserChatMessageData({
    required this.message,
    required this.sender,
    required this.time,
    required this.date,
    required this.read,
    required this.profilePic,
  });
}

class AllChatData {
  final String userName;
  final String sender;
  final String message;
  final String time;
  final bool isRead;
  final String userId;

  AllChatData({
    required this.userName,
    required this.sender,
    required this.message,
    required this.time,
    required this.isRead,
    required this.userId,
  });
}
