import 'package:flutter101/core/enum/available_color.dart';
import 'package:flutter101/core/enum/available_size.dart';
import 'package:flutter101/src/model/product.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class ProductDetailController extends GetxController {
  List<AvailableSize> availableSize = [];
  AvailableSize selectSize = AvailableSize.us7;
  List<AvailableColor> availableColor = [];
  AvailableColor selectColor = AvailableColor.yellow;

  @override
  void onInit() {
    super.onInit();
    _receiveArguments();

    for (var x in AvailableSize.values) {
      availableSize.add(x);
    }
    for (var x in AvailableColor.values) {
      availableColor.add(x);
    }
  }
 late Product produc;
  void _receiveArguments(){
    final arge = Get.arguments[0]["item"];
    produc = arge ;
    // print(arge[0]["string"]);
  }

  void setSeletedSize(AvailableSize size){
    selectSize = size;
    update();
  }

  void setSeletedColor(AvailableColor color){
    selectColor = color;
    update();
  }

  @override
  void onClose() {}

  @override
  void onReady() {}
}
