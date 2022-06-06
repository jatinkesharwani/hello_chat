import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hello_chat/models/chat_message.dart';
import 'package:hello_chat/models/chat_user.dart';
import 'package:hello_chat/widgets/message_bubbles.dart';
import 'package:hello_chat/widgets/rounded_image.dart';

class CustomListUsers extends StatelessWidget {
  final double height;
  final String title;
  final String subtitle;
  final String imgpath;
  final bool isActive;
  final bool isSelected;
  final Function onTap;

  CustomListUsers(
      {required this.height,
        required this.title,
        required this.subtitle,
        required this.imgpath,
        required this.isActive,
        required this.isSelected,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: isSelected
          ? const Icon(
        Icons.check,
        color: Colors.white,
      )
          : null,
      onTap: () => onTap(),
      minVerticalPadding: height * 0.2,
      leading: RoundedImagestatus(
        key: UniqueKey(),
        imgpath: imgpath,
        size: height / 2,
        isActive: isActive,
      ),
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
            color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class CustomListView extends StatelessWidget {
  final double height;
  final String title;
  final String subtitle;
  final String imgpath;
  final bool isActive;
  final bool isActivity;
  final Function onTap;

  CustomListView(
      {required this.height,
        required this.title,
        required this.subtitle,
        required this.imgpath,
        required this.isActive,
        required this.isActivity,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => onTap(),
        minVerticalPadding: height * 0.20,
        leading: RoundedImagestatus(
          key: UniqueKey(),
          size: height / 2,
          isActive: isActive,
          imgpath: imgpath,
        ),
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        subtitle: isActivity
            ? Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitThreeBounce(
              color: Colors.white54,
              size: height * 0.10,
            )
          ],
        )
            : Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ));
  }
}

class CustomChatListView extends StatelessWidget {
  final double width;
  final double lheight;
  final bool isOwnMessage;
  final chatMessage message;
  final ChatUser sender;
  CustomChatListView(
      {required this.width,
        required this.lheight,
        required this.isOwnMessage,
        required this.message,
        required this.sender});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 16),
        width: width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment:
          isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            !isOwnMessage
                ? RoundedImage(
                key: UniqueKey(),
                imgpath: sender.imgurl,
                size: width * 0.088)
                : Container(),
            SizedBox(
              width: width * 0.027,
            ),
            message.type == MessageType.TEXT
                ? TextMessageBubble(
                isOwnMessage: isOwnMessage,
                message: message,
                height: lheight * 0.06,
                width: width)
                : ImageMEssageBubble(
                isOwnMessage: isOwnMessage,
                message: message,
                height: lheight * 0.3,
                width: width * 0.55)
          ],
        ));
  }
}