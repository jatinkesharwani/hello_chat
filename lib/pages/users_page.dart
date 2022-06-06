import 'package:flutter/material.dart';
import 'package:hello_chat/models/chat_user.dart';
import 'package:hello_chat/providers/authentication_provider.dart';
import 'package:hello_chat/providers/users_page_provider.dart';
import 'package:hello_chat/widgets/custom_input_fields.dart';
import 'package:hello_chat/widgets/custom_list_view_tiles.dart';
import 'package:hello_chat/widgets/rounded_button.dart';
import 'package:hello_chat/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class Users_page extends StatefulWidget {
  @override
  _Users_pageState createState() => _Users_pageState();
}

class _Users_pageState extends State<Users_page> {
  late double lwidth;
  late double lheight;
  late AuthenticationProvider auth;
  late UsersProvider pageProvider;
  final TextEditingController searchfieldcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    lheight = MediaQuery.of(context).size.height;
    lwidth = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthenticationProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersProvider>(
            create: (_) => UsersProvider(auth: auth))
      ],
      child: buildUI(),
    );
  }

  Widget buildUI() {
    return Builder(builder: (BuildContext context) {
      pageProvider = context.watch<UsersProvider>();
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
                "Users",
                primaryAction: IconButton(
                  onPressed: () {
                    auth.signOut();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Color.fromRGBO(0, 82, 218, 1.0),
                  ),
                ),
              ),
              InputsearchField(
                onEditingComplete: (value) {
                  pageProvider.getUsers(name: value);
                  FocusScope.of(context).unfocus();
                },
                hintText: "Search a user",
                obscurteText: false,
                controller: searchfieldcontroller,
                icon: Icons.search,
              ),
              usersList(),
              createaChatbutton()
            ],
          ));
    });
  }

  Widget usersList() {
    List<ChatUser>? users = pageProvider.users;
    return Expanded(child: () {
      if (users != null) {
        if (users.isNotEmpty) {
          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomListUsers(
                    height: lheight * 0.1,
                    title: users[index].name,
                    subtitle: "Last Active:${users[index].lastActiveday()}",
                    imgpath: users[index].imgurl,
                    isActive: users[index].wasrecentActive(),
                    isSelected: pageProvider.selectedusers.contains(
                      users[index],
                    ),
                    onTap: () {
                      pageProvider.updateSelectedUsers(users[index]);
                    });
              });
        } else {
          return const Center(
            child: Text(
              "No users found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      } else {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      }
    }());
  }

  Widget createaChatbutton() {
    return Visibility(
        visible: pageProvider.selectedusers.isNotEmpty,
        child: RoundedButton(
          name: pageProvider.selectedusers.length == 1
              ? "Chat with ${pageProvider.selectedusers.first.name}"
              : "Create Group Chat",
          height: lheight * 0.08,
          width: lwidth * 0.80,
          onPressed: () {
            pageProvider.createChat();
          },
        ));
  }
}