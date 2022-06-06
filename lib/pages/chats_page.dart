import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hello_chat/models/chat.dart';
import 'package:hello_chat/models/chat_message.dart';
import 'package:hello_chat/models/chat_user.dart';
import 'package:hello_chat/pages/chat_page.dart';
import 'package:hello_chat/providers/authentication_provider.dart';
import 'package:hello_chat/providers/chats_page_provider.dart';
import 'package:hello_chat/services/navigation_service.dart';
import 'package:hello_chat/widgets/custom_list_view_tiles.dart';
import 'package:hello_chat/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class chats_Page extends StatefulWidget {
  const chats_Page({Key? key}) : super(key: key);

  @override
  _chats_PageState createState() => _chats_PageState();
}

class _chats_PageState extends State<chats_Page> {
  late double lheight;
  late double lwidth;
  late AuthenticationProvider auth;
  late Navigation navigation;
  late ChatsProvider chatProvider;
  @override
  Widget build(BuildContext context) {
    lheight = MediaQuery.of(context).size.height;
    lwidth = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthenticationProvider>(context);
    navigation = GetIt.instance.get<Navigation>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatsProvider>(
          create: (_) => ChatsProvider(auth),
        ),
      ],
      child: buildUI(),
    );
  }

  Widget buildUI() {
    return Builder(
      builder: (BuildContext context) {
        chatProvider = context.watch<ChatsProvider>();
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: lwidth * 0.03, vertical: lheight * 0.02),
          height: lheight * 0.98,
          width: lwidth * 0.97,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Topbar(
                'Chats',
                primaryAction: IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Color.fromRGBO(0, 82, 218, 1.0),
                  ),
                  onPressed: () {
                    auth.signOut();
                  },
                ),
              ),
              chatsList()
            ],
          ),
        );
      },
    );
  }

  Widget chatsList() {
    List<Chat>? chats = chatProvider.chats;

    return Expanded(
      child: (() {
        if (chats != null) {
          if (chats.isNotEmpty) {
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                return chatTile(chats[index]);
              },
            );
          } else {
            return const Center(
              child: Text(
                "No Chats Found.",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        } else {
          return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ));
        }
      })(),
    );
  }

  Widget chatTile(Chat chat) {
    List<ChatUser> _recepients = chat.sendRecepients();
    bool isActive = _recepients.any((d) => d.wasrecentActive());
    String subtitletext = "";
    if (chat.messages.isNotEmpty) {
      subtitletext = chat.messages.first.type != MessageType.TEXT
          ? "Media Attachment"
          : chat.messages.first.content;
    }
    return CustomListView(
        height: lheight * 0.10,
        title: chat.title(),
        subtitle: subtitletext,
        imgpath: chat.imgurl(),
        isActive: isActive,
        isActivity: chat.activity,
        onTap: () {
          navigation.navigateTopage(
            ChatPage(chat: chat),
          );
        });
  }
}