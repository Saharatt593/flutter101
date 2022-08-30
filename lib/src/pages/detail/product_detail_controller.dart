import 'package:flutter101/src/pages/detail/product_detail_page.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class ProductDetailController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    dynamic arge = Get.arguments;
    print(arge);
  }

  @override
  void onClose() {

  }

  @override
  void onReady() {

  }
}