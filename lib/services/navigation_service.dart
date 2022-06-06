import 'package:flutter/material.dart';

class Navigation {
  // ignore: unnecessary_new
  static GlobalKey<NavigatorState> navkey = new GlobalKey<NavigatorState>();
  void removeAndNavigate(String route) {
    navkey.currentState?.popAndPushNamed(route);
  }

  void navigateToroute(String route) {
    navkey.currentState?.pushNamed(route);
  }

  void navigateTopage(Widget page) {
    navkey.currentState
        ?.push(MaterialPageRoute(builder: (BuildContext context) => page));
  }

  void getBack() {
    navkey.currentState?.pop();
  }
}