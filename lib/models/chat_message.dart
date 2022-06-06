import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType {
  TEXT,

  IMAGE,

  UNKNOWN,
}

class chatMessage {
  final String senderId;
  final String content;
  final MessageType type;
  final DateTime sendTime;
  chatMessage(
      {required this.content,
        required this.type,
        required this.senderId,
        required this.sendTime});
  factory chatMessage.fromJson(Map<String, dynamic> json) {
    MessageType _messageType;
    switch (json["type"]) {
      case "text":
        _messageType = MessageType.TEXT;
        break;
      case "image":
        _messageType = MessageType.IMAGE;
        break;
      default:
        _messageType = MessageType.UNKNOWN;
    }
    return chatMessage(
        content: json["content"],
        type: _messageType,
        senderId: json["senderId"],
        sendTime: json["sendTime"].toDate());
  }
  Map<String, dynamic> toJson() {
    String messageType;
    switch (type) {
      case MessageType.TEXT:
        messageType = "text";
        break;
      case MessageType.IMAGE:
        messageType = "image";
        break;
      default:
        messageType = "";
    }
    return {
      "content": content,
      "type": messageType,
      "senderId": senderId,
      "sendTime": Timestamp.fromDate(sendTime),
    };
  }
}