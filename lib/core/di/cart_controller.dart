import 'package:flutter101/src/model/cart_item.dart';
import 'package:flutter101/src/model/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  List<CartItem> carList = [];

  int get cartTotal => carList.length;

  void addItemToCart(CartItem cartItem) {
    final cartItemInCartList = carList
        .firstWhereOrNull((element) => element.product.id == cartItem.product.id);
    if(cartItemInCartList != null){
      cartItemInCartList.quantity +=1;
    }else{
      carList.add(cartItem);
    }

    // carList.add(cartItem);
    update();
  }

  void deleteItemToCart() {
    carList = carList.where((element) => !element.isSelect).toList();
    update();
  }

  void resetSelectedItem() {
    carList = carList.map((e){
      e.isSelect = false;
      return e;
    }).toList();

    update();
  }

  double getPrice(){
    double price = 0 ;
    for(var x in carList){
      price += x.product.price *x.quantity;
    }
    return price;
  }

  void setSelected(CartItem item,bool value){
    item.isSelect = value;

    update();
  }

}
