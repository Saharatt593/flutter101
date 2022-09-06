import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKey{
  static const KEY_ACCESS_TOKEN ="KEY_ACCESS_TOKEN";
  static const KEY_REFRESH_TOKEN ="KEY_REFRESH_TOKEN";
  static const KEY_TOKEN_ID ="KEY_TOKEN_ID";

  static clearAll() async{
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    // final prefs = Get.find<FlutterSecureStorage>();
    // await prefs.deleteAll();

    const prefs = FlutterSecureStorage();
    await prefs.deleteAll();
  }
}