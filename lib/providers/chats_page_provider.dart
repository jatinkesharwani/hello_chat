import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_chat/models/chat.dart';
import 'package:hello_chat/models/chat_message.dart';
import 'package:hello_chat/models/chat_user.dart';
import 'package:hello_chat/providers/authentication_provider.dart';
import 'package:hello_chat/services/database_service.dart';

class ChatsProvider extends ChangeNotifier {
  AuthenticationProvider auth;
  late Database db;
  List<Chat>? chats;
  late StreamSubscription chatStream;
  ChatsProvider(this.auth) {
    db = GetIt.instance.get<Database>();
    getChats();
  }
  @override
  void dispose() {
    chatStream.cancel();
    super.dispose();
  }

  void getChats() async {
    try {
      chatStream = db.getchatsforUser(auth.user.uid).listen((_snapshot) async {
        chats = await Future.wait(
          _snapshot.docs.map(
                (d) async {
              Map<String, dynamic> chatData = d.data() as Map<String, dynamic>;
              //Get users in chat
              List<ChatUser> _members = [];
              for (var _uid in chatData["members"]) {
                DocumentSnapshot userSnapshot = await db.getUser(_uid);
                Map<String, dynamic> userData =
                userSnapshot.data() as Map<String, dynamic>;

                userData["uid"] = _uid;

                _members.add(ChatUser.fromJSON(userData));
              }

              //Get Last Message For Chat
              List<chatMessage> messages = [];

              QuerySnapshot _chatmessage =
              await db.getlastMessageforachat(d.id);
              if (_chatmessage.docs.isNotEmpty) {
                Map<String, dynamic> messageData =
                _chatmessage.docs.first.data()! as Map<String, dynamic>;

                chatMessage message = chatMessage.fromJson(messageData);
                messages.add(message);
              }
              return Chat(
                  uid: d.id,
                  currentUserid: auth.user.uid,
                  activity: chatData["isActivity"],
                  group: chatData["isgroup"],
                  members: _members,
                  messages: messages);
            },
          ).toList(),
        );
        notifyListeners();
      });
    } catch (e) {
      print("Error getting chats");
      print(e);
    }
  }
}