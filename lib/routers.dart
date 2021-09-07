import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String reset_password = '/reset_password';
  static const String change_password = '/change_password';

  static final routes = <String, WidgetBuilder>{
    // home: (BuildContext context) => HomePage(),
  };
}
