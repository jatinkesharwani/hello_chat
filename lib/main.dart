import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hello_chat/pages/home_page.dart';
import 'package:hello_chat/pages/login_page.dart';
import 'package:hello_chat/pages/register_page.dart';
import 'package:hello_chat/pages/splash_page.dart';
import 'package:hello_chat/providers/authentication_provider.dart';
import 'package:hello_chat/services/navigation_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(SplashScreen(
      key: UniqueKey(),
      InitializationComplete: () {
        runApp(const MyApp());
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (BuildContext context) {
            return AuthenticationProvider();
          },
        )
      ],
      child: MaterialApp(
        title: 'Chatter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            backgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
            scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Color.fromRGBO(30, 29, 37, 1.0))),
        navigatorKey: Navigation.navkey,
        initialRoute: '/login',
        routes: {
          '/login': (BuildContext context) => const LoginPage(),
          '/register': (BuildContext context) => const RegisterPage(),
          '/home': (BuildContext context) => const HomePage()
        },
      ),
    );
  }
}