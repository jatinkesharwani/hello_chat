import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:hello_chat/models/chat.dart';
import 'package:hello_chat/models/chat_user.dart';
import 'package:hello_chat/pages/chat_page.dart';
import 'package:hello_chat/providers/authentication_provider.dart';
import 'package:hello_chat/services/database_service.dart';
import 'package:hello_chat/services/navigation_service.dart';

class UsersProvider extends ChangeNotifier {
  AuthenticationProvider auth;
  late Database database;
  late Navigation navigation;
  List<ChatUser>? users;
  late List<ChatUser> selectedusers;
  List<ChatUser> get selectedUsers {
    return selectedusers;
  }

  UsersProvider({required this.auth}) {
    selectedusers = [];
    database = GetIt.instance.get<Database>();
    navigation = GetIt.instance.get<Navigation>();
    getUsers();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void getUsers({String? name}) async {
    selectedusers = [];
    try {
      database.getUsers(name: name).then((snapshot) {
        users = snapshot.docs.map((_doc) {
          Map<String, dynamic> data = _doc.data() as Map<String, dynamic>;
          data["uid"] = _doc.id;
          return ChatUser.fromJSON(data);
        }).toList();
        notifyListeners();
      });
    } catch (e) {
      print("Error getting users");
      print(e);
    }
  }

  void updateSelectedUsers(ChatUser user) {
    if (selectedusers.contains(user)) {
      selectedusers.remove(user);
    } else {
      selectedusers.add(user);
    }
    notifyListeners();
  }

  void createChat() async {
    try {
      List<String> membersIds = selectedusers.map((user) => user.uid).toList();

      membersIds.add(auth.user.uid);

      bool isgroup = selectedusers.length > 1;
      DocumentReference? _doc = await database.createChat(
        {
          "isgroup": isgroup,
          "isActivity": false,
          "members": membersIds,
        },
      );

      List<ChatUser> members = [];
      for (var _uid in membersIds) {
        DocumentSnapshot snapshot = await database.getUser(_uid);
        Map<String, dynamic> userdata = snapshot.data() as Map<String, dynamic>;
        userdata["uid"] = snapshot.id;
        members.add(ChatUser.fromJSON(userdata));
      }
      ChatPage chatpage = ChatPage(
          chat: Chat(
              uid: _doc!.id,
              currentUserid: auth.user.uid,
              activity: false,
              group: isgroup,
              members: members,
              messages: []));
      selectedusers = [];
      notifyListeners();
      navigation.navigateTopage(chatpage);
    } catch (e) {
      print("Error creating chat");
      print(e);
    }
  }
}