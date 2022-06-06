import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hello_chat/models/chat_message.dart';
import 'package:hello_chat/providers/authentication_provider.dart';
import 'package:hello_chat/services/cloud_storage_service.dart';
import 'package:hello_chat/services/database_service.dart';
import 'package:hello_chat/services/media_service.dart';
import 'package:hello_chat/services/navigation_service.dart';

class ChatProvider extends ChangeNotifier {
  late Database db;
  late CloudStorage storage;
  late MediaService media;
  late Navigation navigation;
  AuthenticationProvider auth;
  ScrollController messageListviewcontroller;
  String chatId;
  List<chatMessage>? messages;

  late StreamSubscription messagesstream;
  late StreamSubscription keyboardvisibility;
  late KeyboardVisibilityController keyboardVisibilityController;
  String? message;
  String get gmessage {
    return message!;
  }

  void set gmessage(String value) {
    message = value;
  }

  ChatProvider(this.chatId, this.auth, this.messageListviewcontroller) {
    db = GetIt.instance.get<Database>();
    storage = GetIt.instance.get<CloudStorage>();
    media = GetIt.instance.get<MediaService>();
    navigation = GetIt.instance.get<Navigation>();
    keyboardVisibilityController = KeyboardVisibilityController();
    listentoMessages();
    listentoKeyboardchanges();
  }

  @override
  void dispose() {
    messagesstream.cancel();
    super.dispose();
  }

  void listentoMessages() {
    try {
      messagesstream = db.streamMessagesforchat(chatId).listen(
            (snapshot) {
          List<chatMessage> _messages = snapshot.docs.map((m) {
            Map<String, dynamic> messageData = m.data() as Map<String, dynamic>;
            return chatMessage.fromJson(messageData);
          }).toList();
          messages = _messages;
          notifyListeners();
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            if (messageListviewcontroller.hasClients) {
              messageListviewcontroller
                  .jumpTo(messageListviewcontroller.position.maxScrollExtent);
            }
          });
        },
      );
    } catch (e) {
      print("Error Getting messages");
      print(e);
    }
  }

  void listentoKeyboardchanges() {
    keyboardvisibility = keyboardVisibilityController.onChange.listen((event) {
      db.updateChatdata(chatId, {"isActivity": event});
    });
  }

  void sendTextmessage() {
    if (message != null) {
      chatMessage _messagetoSend = chatMessage(
          content: message!,
          type: MessageType.TEXT,
          senderId: auth.user.uid,
          sendTime: DateTime.now());
      db.addMesaagetochat(chatId, _messagetoSend);
    }
  }

  void sendImagemessage() async {
    try {
      PlatformFile? file = await media.imagefromLibrary();
      if (file != null) {
        String? downloadUrl =
        await storage.saveChatimage(chatId, auth.user.uid, file);
        chatMessage _messagetoSend = chatMessage(
            content: downloadUrl!,
            type: MessageType.IMAGE,
            senderId: auth.user.uid,
            sendTime: DateTime.now());
        db.addMesaagetochat(chatId, _messagetoSend);
      }
    } catch (e) {
      print("Error Getting messages");
      print(e);
    }
  }

  void deleteChat() {
    goBack();
    db.deleteaChat(chatId);
  }

  void goBack() {
    navigation.getBack();
  }
}