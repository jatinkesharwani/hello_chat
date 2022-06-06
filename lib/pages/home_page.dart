import 'package:flutter/material.dart';
import 'package:hello_chat/pages/chats_page.dart';
import 'package:hello_chat/pages/users_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current_page = 0;
  // ignore: prefer_const_constructors
  final List<Widget> pages = [chats_Page(), Users_page()];
  @override
  Widget build(BuildContext context) {
    return buildUI();
  }

  Widget buildUI() {
    return Scaffold(
      body: pages[current_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current_page,
        onTap: (index) {
          setState(() {
            current_page = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: "Chats", icon: Icon(Icons.chat_bubble_sharp)),
          BottomNavigationBarItem(
              label: "Users", icon: Icon(Icons.supervised_user_circle_sharp))
        ],
      ),
    );
  }
}