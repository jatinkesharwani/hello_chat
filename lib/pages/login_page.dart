import 'package:flutter/material.dart';
import 'package:hello_chat/providers/authentication_provider.dart';
import 'package:hello_chat/services/navigation_service.dart';
import 'package:hello_chat/widgets/custom_input_fields.dart';
import 'package:hello_chat/widgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double lheight;
  late double lwidth;

  final loginformkey = GlobalKey<FormState>();
  String? email;
  String? password;
  late AuthenticationProvider auth;
  late Navigation navigation;
  @override
  Widget build(BuildContext context) {
    lheight = MediaQuery.of(context).size.height;
    lwidth = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthenticationProvider>(context);
    navigation = GetIt.instance.get<Navigation>();
    return buildUi();
  }

  Widget buildUi() {
    return Scaffold(
      body: Container(
        height: lheight * 0.98,
        width: lwidth * 0.97,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: lwidth * 0.03, vertical: lheight * 0.02),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: lheight * 0.0009,
              ),
              pageTitle(),
              SizedBox(
                height: lheight * 0.05,
              ),
              loginField(),
              forgetPassword(),
              SizedBox(
                height: lheight * 0.05,
              ),
              _loginbutton(),
              SizedBox(
                height: lheight * 0.027,
              ),
              registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget forgetPassword() {
    return Row(
      children: [
        SizedBox(
          width: lwidth * 0.57,
        ),
        GestureDetector(
          onTap: () {
            if (loginformkey.currentState!.validate()) {
              loginformkey.currentState!.save();
              auth.forgotPassword(email!, context);
            }
          },
          child: const Text("Forgot Password ?",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.blueAccent)),
        ),
      ],
    );
  }

  Widget registerButton() {
    return Row(
      children: [
        SizedBox(
          width: lwidth * 0.15,
        ),
        const Text(
          "Not an existing cutomer ? ",
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
          child: const Text(
            "Register Here",
            style: TextStyle(color: Colors.blueAccent),
          ),
          onTap: () => navigation.navigateToroute('/register'),
        )
      ],
    );
  }

  Widget loginField() {
    return Container(
      height: lheight * 0.25,
      //   width: lwidth,
      child: Form(
        key: loginformkey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            InputFormField(
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
                regEx: r".{8,}",
                hintText: "Password",
                obscureText: true)
          ],
        ),
      ),
    );
  }

  Widget _loginbutton() {
    return RoundedButton(
        name: "Login",
        height: lheight * 0.06,
        width: lwidth * 0.5,
        onPressed: () {
          if (loginformkey.currentState!.validate()) {
            loginformkey.currentState!.save();
            auth.loginusingEmailpassword(email!, password!, context);
          }
        });
  }

  Widget pageTitle() {
    return Column(
      children: [
        Container(
          height: lheight * 0.10,
          child: const Text(
            "Chatter",
            style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontFamily: "",
                fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          width: 200,
          height: 180,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/login.jpg'), fit: BoxFit.fill),
          ),
        ),
      ],
    );
  }
}