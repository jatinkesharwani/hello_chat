import 'package:hello_chat/models/chat_message.dart';
import 'package:hello_chat/models/chat_user.dart';

class Chat {
  final String uid;
  final String currentUserid;
  final bool activity;
  final bool group;
  final List<ChatUser> members;
  final List<chatMessage> messages;

  late final List<ChatUser> recepients;
  Chat({
    required this.uid,
    required this.currentUserid,
    required this.activity,
    required this.group,
    required this.members,
    required this.messages,
  }) {
    recepients = members.where((i) => i.uid != currentUserid).toList();
  }
  List<ChatUser> sendRecepients() {
    return recepients;
  }

  String title() {
    return !group
        ? recepients.first.name
        : recepients.map((user) => user.name).join(",");
  }

  String imgurl() {
    return !group
        ? recepients.first.imgurl
        : "https://e7.pngegg.com/pngimages/380/670/png-clipart-group-chat-logo-blue-area-text-symbol-metroui-apps-live-messenger-alt-2-blue-text.png";
  }
}