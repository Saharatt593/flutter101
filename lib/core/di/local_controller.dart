import 'package:flutter/material.dart';
import 'package:flutter101/core/config/shared_preferences_key.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalController extends GetxController {

  static const defaultLocale = Locale('en', '');

  static const supportedLocales = [
    Locale('en', ''),
    Locale('th', ''),
  ];

  static const String prefSelectedLanguageCode = SharedPreferencesKey.KEY_LANGUAGE_CODE;


  @override
  void onInit() {
    super.onInit();

    _loadLocale();
  }

  void _loadLocale() async {
    final locale = await _getLocale();
    Get.updateLocale(locale);
  }

  Future<Locale> _setLocale(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefSelectedLanguageCode, languageCode);
    return _locale(languageCode);
  }

  Future<Locale> _getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString(prefSelectedLanguageCode) ?? "en";
    return _locale(languageCode);
  }

  Locale _locale(String languageCode) {
    return languageCode.isNotEmpty
        ? Locale(languageCode, '')
        : defaultLocale;
  }

  void changeLanguage(String selectedLanguageCode) async {
    Get.updateLocale(await _setLocale(selectedLanguageCode));
  }
}