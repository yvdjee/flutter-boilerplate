import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String users_listing = '/users_listing';
  static const String reset_password = '/reset_password';
  static const String approval_email = '/approval_email';
  static const String change_password = '/change_password';
  static const String form_types = '/form_types';
  static const String district_list = '/district_list';

  static final routes = <String, WidgetBuilder>{
    // district_list: (BuildContext context) => DistrictPage(),
  };
}
