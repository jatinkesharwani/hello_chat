import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:hello_chat/providers/authentication_provider.dart';
import 'package:hello_chat/services/cloud_storage_service.dart';
import 'package:hello_chat/services/database_service.dart';
import 'package:hello_chat/services/media_service.dart';
import 'package:hello_chat/services/navigation_service.dart';
import 'package:hello_chat/widgets/custom_input_fields.dart';
import 'package:hello_chat/widgets/rounded_button.dart';
import 'package:hello_chat/widgets/rounded_image.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double lheight;
  late double lwidth;
  late AuthenticationProvider auth;
  late Database database;
  late CloudStorage storage;
  late Navigation navigation;
  String? name;
  String? email;
  String? password;
  bool obscureText = true;

  PlatformFile? profile_Image;
  TextEditingController pass = TextEditingController();
  final registerFormkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthenticationProvider>(context);
    database = GetIt.instance.get<Database>();
    storage = GetIt.instance.get<CloudStorage>();
    navigation = GetIt.instance.get<Navigation>();
    lheight = MediaQuery.of(context).size.height;
    lwidth = MediaQuery.of(context).size.width;
    return buildUI();
  }

  Widget buildUI() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: lwidth * 0.03, vertical: lheight * 0.02),
        height: lheight * 0.98,
        width: lwidth * 0.97,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              profileImage(),
              SizedBox(
                height: lheight * 0.07,
              ),
              registerForm(),
              SizedBox(
                height: lheight * 0.05,
              ),
              registerButton(),
              SizedBox(
                height: lheight * 0.02,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget registerButton() {
    return RoundedButton(
      name: "Register",
      height: lheight * 0.065,
      width: lwidth * 0.5,
      onPressed: () async {
        if (registerFormkey.currentState!.validate() && profile_Image != null) {
          registerFormkey.currentState!.save();
          String? uid = await auth.registerUser(email!, password!, context);
          String? imgurl = await storage.saveuserImage(uid!, profile_Image!);
          await database.createUser(uid, email!, name!, imgurl!);
          await auth.signOut();
          await auth.loginusingEmailpassword(email!, password!, context);
        }
      },
    );
  }

  Widget registerForm() {
    return Container(
        height: lheight * 0.45,
        child: Form(
          key: registerFormkey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputFormField(
                  onSaved: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  regEx: r'.{8,}',
                  hintText: "Name",
                  obscureText: false),
              InputFormField(
                  onSaved: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  regEx:
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  hintText: "Email",
                  obscureText: false),
              TextFormField(
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
                controller: pass,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    fillColor: const Color.fromRGBO(30, 29, 37, 1.0),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60.0),
                        borderSide: const BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60.0),
                        borderSide: BorderSide.none),
                    hintText: "Enter your Password",
                    hintStyle: const TextStyle(color: Colors.white54)),
                validator: (value) {
                  return RegExp(r'.{8,}').hasMatch(value!)
                      ? null
                      : "Enter a valid Password";
                },
              ),
              TextFormField(
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                obscureText: !obscureText,
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        }),
                    fillColor: const Color.fromRGBO(30, 29, 37, 1.0),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60.0),
                        borderSide: const BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60.0),
                        borderSide: BorderSide.none),
                    hintText: "Enter your password",
                    hintStyle: const TextStyle(color: Colors.white54)),
                validator: (value) {
                  return value == pass.text ? null : "Password not matching";
                },
              )
            ],
          ),
        ));
  }

  Widget profileImage() {
    return GestureDetector(
      onTap: () {
        GetIt.instance.get<MediaService>().imagefromLibrary().then(
              (file) {
            setState(
                  () {
                profile_Image = file;
              },
            );
          },
        );
      },
      child: () {
        if (profile_Image != null) {
          return RoundedImageFile(
            key: UniqueKey(),
            imageu: profile_Image!,
            size: lheight * 0.15,
          );
        } else {
          return RoundedImage(
              key: UniqueKey(),
              imgpath: "https://i.pravatar.cc/150?img=13",
              size: lheight * 0.15);
        }
      }(),
    );
  }
}