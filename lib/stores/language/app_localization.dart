import 'package:flutter/material.dart';

class AppLocalization extends ChangeNotifier {
  Locale _locale = Locale('fr');
  String selectedLanguageCode = 'fr';

  Locale get getLocale => _locale;

  toggleLocal(Locale locale) {
    this._locale = locale;
    this.selectedLanguageCode = locale.toLanguageTag();
    notifyListeners();
  }
}
