import 'package:flutter101/core/di/cart_controller.dart';
import 'package:get/instance_manager.dart';

Future<void> initGetX() async{
  // Get.put(CartController());
  Get.lazyPut<CartController>(() => CartController());
}