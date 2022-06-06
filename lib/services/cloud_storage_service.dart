import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

const String user_collection = "Users";

class CloudStorage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  CloudStorage();
  Future<String?> saveuserImage(String uid, PlatformFile file) async {
    try {
      Reference ref =
      storage.ref().child('images/users/$uid/profile.${file.extension}');
      UploadTask task = ref.putFile(File(file.path!));
      return await task.then(
            (result) => result.ref.getDownloadURL(),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<String?> saveChatimage(
      String chatId, String userId, PlatformFile file) async {
    try {
      Reference ref = storage.ref().child(
          'images/chats/$chatId/${userId}_${Timestamp.now().millisecondsSinceEpoch}.${file.extension}');
      UploadTask task = ref.putFile(File(file.path!));
      return await task.then(
            (result) => result.ref.getDownloadURL(),
      );
    } catch (e) {
      print(e);
    }
  }
}