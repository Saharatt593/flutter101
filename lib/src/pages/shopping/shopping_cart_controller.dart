import 'package:flutter101/core/enum/shopping_cart_mode.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ShoppingCartPageController extends GetxController {
  ShoppingCartMode _shoppingCartMode = ShoppingCartMode.normal;

  ShoppingCartMode get shoppingCartMode => _shoppingCartMode;

  void toggleMode() {
    _shoppingCartMode = _shoppingCartMode.toggle();
    update();
  }
}
