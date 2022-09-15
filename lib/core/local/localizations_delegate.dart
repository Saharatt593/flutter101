import 'package:flutter/material.dart';
import 'package:flutter101/core/local/languages/language_en.dart';
import 'package:flutter101/core/local/languages/language_th.dart';
import 'package:flutter101/core/local/languages/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {

  AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'th',].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'th':
        return LanguageTH();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}