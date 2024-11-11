

import 'package:flutter/material.dart';

import '../l10n/L10n.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;
  void setLocale(Locale loc) {
    if (!L10n.all.contains(loc)) return;
    _locale = loc;
    notifyListeners();
  }
  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}