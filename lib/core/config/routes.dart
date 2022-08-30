import 'package:flutter/material.dart';
import 'package:flutter101/src/pages/detail/product_detail_page.dart';
import 'package:flutter101/src/pages/main/main_page.dart';
import 'package:flutter101/src/pages/shopping/shopping_cart_page.dart';
import 'package:get/route_manager.dart';

class Routes {
  static const rootPage = "/";
  static const detailPage = "/detail";
  static const shoppingCartPage = "/shoppingCart";

  // static Map<String, WidgetBuilder> getRoute() {
  //   return <String, WidgetBuilder>{
  //     rootPage: (_) => MainPage(),
  //     detailPage: (_) =>  ProductDetailPage(),
  //     shoppingCartPage: (_) => const ShoppingCartPage(),
  //   };
  // }

  static List<GetPage> getPageRoute() {
    return [
      GetPage(
        name: rootPage,
        page: () => MainPage(),
        transition: Transition.fade
      ),
      GetPage(
        name: detailPage,
        page: () => ProductDetailPage(),
          transition: Transition.fade
      ),
      GetPage(
        name: shoppingCartPage,
        page: () =>const ShoppingCartPage(),
          transition: Transition.fade
      ),
    ];
  }
}
