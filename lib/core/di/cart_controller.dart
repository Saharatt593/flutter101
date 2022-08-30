import 'package:flutter101/src/model/product.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CartController extends GetxController {
  List<dynamic> carList = [];

  int get cartTotal => carList.length;

  void addItemToCart(Product product){

  }

  void deleteItemToCart(Product product){

  }


}
