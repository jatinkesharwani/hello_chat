class ChatUser {
  final String uid;
  final String name;
  final String email;
  final String imgurl;
  late DateTime lastActive;
  ChatUser(
      {required this.uid,
        required this.name,
        required this.email,
        required this.imgurl,
        required this.lastActive});
  factory ChatUser.fromJSON(Map<String, dynamic> json) {
    return ChatUser(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        imgurl: json["imgurl"],
        lastActive: json["lastActive"].toDate());
  }
  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "name": name,
      "lastActive": lastActive,
      "imgurl": imgurl
    };
  }

  String lastActiveday() {
    return "${lastActive.month}/${lastActive.day}/${lastActive.year}";
  }

  bool wasrecentActive() {
    return DateTime.now().difference(lastActive).inHours < 1;
  }
}