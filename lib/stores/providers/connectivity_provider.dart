import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:domodar/utils/app_utils/connectivity_check.dart';
import 'package:flutter/cupertino.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool _result = true;

  bool get isOffline => !_result;

  setConnectivityResult(ConnectivityResult res, BuildContext context) {
    sleep(Duration(milliseconds: 200));
    isNetworkAvailable().then((status) {
      _result = status;
      notifyListeners();
    });
  }
}
