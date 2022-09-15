import 'package:flutter101/core/di/cart_controller.dart';
import 'package:flutter101/core/di/local_controller.dart';
import 'package:flutter101/src/pages/login/auth_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/instance_manager.dart';

Future<void> initGetX() async{
  Get.put(AuthController());
  Get.put(CartController());

  Get.put<FlutterSecureStorage>(const FlutterSecureStorage());

  Get.put(LocalController());
  // Get.lazyPut<CartController>(() => CartController());
}