import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_chat/models/chat_message.dart';
import 'package:hello_chat/services/cloud_storage_service.dart';

const String USER_COLLECTION = "Users";

const String chat_collection = "Chats";

const String message_collection = "messages";

class Database {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Database();
  Future<DocumentSnapshot> getUser(String uid) {
    return db.collection(USER_COLLECTION).doc(uid).get();
  }

  Future<QuerySnapshot> getUsers({String? name}) {
    Query query = db.collection(user_collection);
    if (name != null) {
      query = query
          .where("name", isGreaterThanOrEqualTo: name)
          .where("name", isLessThanOrEqualTo: name + "z");
    }
    return query.get();
  }

  Stream<QuerySnapshot> getchatsforUser(String uid) {
    return db
        .collection(chat_collection)
        .where("members", arrayContains: uid)
        .snapshots();
  }

  Future<QuerySnapshot> getlastMessageforachat(String chatId) {
    return db
        .collection(chat_collection)
        .doc(chatId)
        .collection(message_collection)
        .orderBy("sendTime", descending: true)
        .limit(1)
        .get();
  }

  Stream<QuerySnapshot> streamMessagesforchat(String chatId) {
    return db
        .collection(chat_collection)
        .doc(chatId)
        .collection(message_collection)
        .orderBy("sendTime", descending: false)
        .snapshots();
  }

  Future<void> addMesaagetochat(String chatId, chatMessage message) async {
    try {
      await db
          .collection(chat_collection)
          .doc(chatId)
          .collection(message_collection)
          .add(message.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateChatdata(String chatId, Map<String, dynamic> data) async {
    try {
      await db.collection(chat_collection).doc(chatId).update(data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatelastscene(String uid) async {
    try {
      await db
          .collection(USER_COLLECTION)
          .doc(uid)
          .update({"lastActive": DateTime.now().toUtc()});
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteaChat(String chatId) async {
    try {
      await db.collection(chat_collection).doc(chatId).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> createUser(
      String uid, String email, String name, String imgurl) async {
    try {
      await db.collection(USER_COLLECTION).doc(uid).set({
        'email': email,
        "imgurl": imgurl,
        "name": name,
        "lastActive": DateTime.now().toUtc()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<DocumentReference?> createChat(Map<String, dynamic> data) async {
    try {
      DocumentReference chat = await db.collection(chat_collection).add(data);

      return chat;
    } catch (e) {
      print(e);
    }
  }
}