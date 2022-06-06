import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hello_chat/models/chat_user.dart';
import 'package:hello_chat/services/database_service.dart';
import 'package:hello_chat/services/navigation_service.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth auth;
  late final Navigation navigation;
  late final Database database;
  late ChatUser user;
  AuthenticationProvider() {
    auth = FirebaseAuth.instance;
    navigation = GetIt.instance.get<Navigation>();
    database = GetIt.instance.get<Database>();

    auth.authStateChanges().listen((_user) {
      if (_user != null) {
        print("Logged" + _user.uid);
        database.updatelastscene(_user.uid);
        database.getUser(_user.uid).then((_snapshot) {
          Map<String, dynamic> _userData =
          _snapshot.data()! as Map<String, dynamic>;
          print(_userData);
          user = ChatUser.fromJSON(
            {
              "uid": _user.uid.toString(),
              "name": _userData["name"],
              "email": _userData["email"],
              "lastActive": _userData["lastActive"],
              "imgurl": _userData["imgurl"],
            },
          );
          print(user.toMap());
          navigation.removeAndNavigate('/home');
        });
      } else {
        print("not authenticated");
        navigation.removeAndNavigate('/login');
      }
    });
  }
  Future<void> loginusingEmailpassword(
      String email, String password, BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      print(auth.currentUser);
    } on FirebaseAuthException {
      print("Error logging user into Firebase");
      final snackBar = SnackBar(
        content: Text(
          "Error logging user into Firebase!!",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color.fromRGBO(36, 35, 69, 1.0),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e);
    }
  }

  Future<String?> registerUser(
      String email, String password, BuildContext context) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user!.uid;
    } on FirebaseAuthException {
      print("Error registering user");
      final snackBar = SnackBar(
        content: Text(
          "Error registering user",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color.fromRGBO(36, 35, 69, 1.0),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e);
    }
  }

  Future<void> forgotPassword(String email, BuildContext context) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      final snackBar = SnackBar(
        content: Text(
          "Check your Email",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color.fromRGBO(36, 35, 69, 1.0),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}