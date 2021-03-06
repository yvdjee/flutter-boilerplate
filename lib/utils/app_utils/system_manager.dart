import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../animations/route_transation.dart';

hideStatusBar() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: <SystemUiOverlay>[]);
}

revertStatusBar() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: <SystemUiOverlay>[SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
}

pushScreen(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (ctx) => page));
}

pushScreenWithTransitions(
    BuildContext context, Widget page, AnimationType animation) {
  Navigator.of(context).push(PageRouteTransition(
      animationType: animation, builder: (context) => page));
}

pushNamed(BuildContext context, String routeName, {Object? arguments}) {
  Navigator.of(context).pushNamed(routeName, arguments: arguments);
}

pushReplaceScreen(BuildContext context, Widget page) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => page));
}

pushRemoveUntil(BuildContext context, String route) {
  Navigator.of(context)
      .pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
}
