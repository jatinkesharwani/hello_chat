import 'package:flutter/material.dart';
import 'package:hello_chat/models/chat.dart';
import 'package:hello_chat/models/chat_message.dart';
import 'package:hello_chat/providers/authentication_provider.dart';
import 'package:hello_chat/providers/chat_page_provider.dart';
import 'package:hello_chat/widgets/custom_input_fields.dart';
import 'package:hello_chat/widgets/custom_list_view_tiles.dart';
import 'package:hello_chat/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;

  ChatPage({required this.chat});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late double lheight;
  late double lwidth;
  late AuthenticationProvider auth;
  late ChatProvider pageprovider;

  late GlobalKey<FormState> messageFormstate;
  late ScrollController messageListviewcontroller;
  @override
  void initState() {
    super.initState();
    messageFormstate = GlobalKey<FormState>();
    messageListviewcontroller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    lheight = MediaQuery.of(context).size.height;
    lwidth = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthenticationProvider>(context);
    //  navigation = GetIt.instance.get<Navigation>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatProvider>(
            create: (_) => ChatProvider(
              this.widget.chat.uid,
              auth,
              messageListviewcontroller,
            ))
      ],
      child: buildUI(),
    );
  }

  Widget buildUI() {
    //  String imgurl = this.widget.chat.imgurl();
    return Builder(builder: (BuildContext context) {
      pageprovider = context.watch<ChatProvider>();
      return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: lwidth * 0.03,
              vertical: lheight * 0.02,
            ),
            height: lheight,
            width: lwidth,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Topbarforachat(
                    this.widget.chat.title(), this.widget.chat.imgurl(),
                    fontSize: 17,
                    primaryAction: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromRGBO(0, 82, 218, 1.0),
                      ),
                      onPressed: () {
                        pageprovider.deleteChat();
                      },
                    ),
                    secondaryAction: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color.fromRGBO(0, 82, 218, 1.0),
                      ),
                      onPressed: () {
                        pageprovider.goBack();
                      },
                    )),
                messagesListView(),
                sendmessageForm(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget messagesListView() {
    if (pageprovider.messages != null) {
      if (pageprovider.messages!.isNotEmpty) {
        return Container(
            height: lheight * 0.74,
            child: ListView.builder(
                controller: messageListviewcontroller,
                itemCount: pageprovider.messages!.length,
                itemBuilder: (BuildContext context, int index) {
                  chatMessage message = pageprovider.messages![index];
                  bool isOwnMEssage = message.senderId == auth.user.uid;
                  // ignore: avoid_unnecessary_containers
                  return Container(
                      child: CustomChatListView(
                          width: lwidth * 0.80,
                          lheight: lheight,
                          isOwnMessage: isOwnMEssage,
                          message: message,
                          sender: this
                              .widget
                              .chat
                              .members
                              .where((m) => m.uid == message.senderId)
                              .first));
                }));
      } else {
        return const Align(
            alignment: Alignment.center,
            child: Text(
              "Be the first to say Hi!",
              style: TextStyle(color: Colors.white),
            ));
      }
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
  }

  Widget sendmessageForm() {
    return Container(
        height: lheight * 0.06,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(30, 29, 37, 1.0),
            borderRadius: BorderRadius.circular(100)),
        margin: EdgeInsets.symmetric(
          horizontal: lwidth * 0.04,
          vertical: lheight * 0.03,
        ),
        child: Form(
          key: messageFormstate,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              messageTextField(),
              sendMessageButton(),
              imageMessageButton()
            ],
          ),
        ));
  }

  Widget messageTextField() {
    return SizedBox(
      width: lwidth * 0.65,
      child: InputFormField(
          onSaved: (value) {
            pageprovider.gmessage = value;
          },
          regEx: r"^(?!\s*$).+",
          hintText: "Type a message",
          obscureText: false),
    );
  }

  Widget sendMessageButton() {
    double size = lheight * 0.05;

    return Container(
      height: size,
      width: size,
      child: IconButton(
        icon: const Icon(
          Icons.send,
          color: Colors.white,
        ),
        onPressed: () {
          if (messageFormstate.currentState!.validate()) {
            messageFormstate.currentState!.save();
            pageprovider.sendTextmessage();
            messageFormstate.currentState!.reset();
          }
        },
      ),
    );
  }

  Widget imageMessageButton() {
    double size = lheight * 0.04;

    return Container(
        height: size,
        width: size,
        child: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(0, 2, 218, 1.0),
          child: const Icon(Icons.camera_enhance),
          onPressed: () {
            pageprovider.sendImagemessage();
          },
        ));
  }
}
