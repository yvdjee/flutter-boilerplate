import 'package:flutter/material.dart';

class AppLocalization extends ChangeNotifier {
  Locale _locale = Locale('ar');
  String selectedLanguageCode = 'ar';

  Locale get getLocale => _locale;

  toggleLocal(Locale locale) {
    this._locale = locale;
    this.selectedLanguageCode = "ar";
    notifyListeners();
  }
}
