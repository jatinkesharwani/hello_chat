import 'package:flutter/material.dart';
import 'package:hello_chat/models/chat_message.dart';
import 'package:timeago/timeago.dart' as timeago;

class TextMessageBubble extends StatelessWidget {
  final bool isOwnMessage;
  final chatMessage message;
  final double height;
  final double width;
  TextMessageBubble(
      {required this.isOwnMessage,
        required this.message,
        required this.height,
        required this.width});

  @override
  Widget build(BuildContext context) {
    List<Color> messagecolor = isOwnMessage
        ? [
      const Color.fromRGBO(0, 136, 249, 1.0),
      const Color.fromRGBO(0, 82, 218, 1.0)
    ]
        : [
      const Color.fromRGBO(51, 49, 68, 1.0),
      const Color.fromRGBO(51, 49, 68, 1.0),
    ];
    return Container(
      height: height + (message.content.length / 20 * 6.0),
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            colors: messagecolor,
            stops: [0.30, 0.7],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.content,
            style: const TextStyle(color: Colors.white),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              timeago.format(message.sendTime),
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageMEssageBubble extends StatelessWidget {
  final bool isOwnMessage;
  final chatMessage message;
  final double height;
  final double width;

  const ImageMEssageBubble(
      {required this.isOwnMessage,
        required this.message,
        required this.height,
        required this.width});

  @override
  Widget build(BuildContext context) {
    List<Color> messagecolor = isOwnMessage
        ? [
      const Color.fromRGBO(0, 136, 249, 1.0),
      const Color.fromRGBO(0, 82, 218, 1.0)
    ]
        : [
      const Color.fromRGBO(51, 49, 68, 1.0),
      const Color.fromRGBO(51, 49, 68, 1.0),
    ];
    DecorationImage _image = DecorationImage(
        image: NetworkImage(message.content), fit: BoxFit.cover);
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
            colors: messagecolor,
            stops: const [0.30, 0.7],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: _image,
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              timeago.format(message.sendTime),
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}