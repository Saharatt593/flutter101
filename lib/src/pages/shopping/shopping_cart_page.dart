import 'package:flutter/material.dart';
import 'package:flutter101/core/di/cart_controller.dart';
import 'package:flutter101/core/widgets/header.dart';
import 'package:flutter101/src/pages/shopping/shopping_cart_content.dart';
import 'package:flutter101/src/pages/shopping/shopping_cart_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class ShoppingCartPage extends StatelessWidget {
  ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ShoppingCartPageController>(
          init: ShoppingCartPageController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Header(
                  headLine1: "Shopping",
                  headLine2: "Cart",
                  isShop: true,
                  mode: controller.shoppingCartMode,
                  onPressedIcon: () {
                    controller.toggleMode();

                    Get.find<CartController>().resetSelectedItem();
                  },
                ),
                Expanded(child: ShoppingCartContent()),
              ],
            );
          },
        ),
      ),
    );
  }
}
