import 'package:flutter/material.dart';
import 'package:flutter101/src/pages/detail/product_detail_page.dart';
import 'package:flutter101/src/pages/main/main_page.dart';
import 'package:flutter101/src/pages/shopping/shopping_cart_page.dart';

class Routes {
  static const rootPage = "/";
  static const detailPage = "/detail";
  static const shoppingCartPage = "/shoppingCart";

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      rootPage: (_) => const MainPage(),
      detailPage: (_) => const ProductDetailPage(),
      shoppingCartPage: (_) => const ShoppingCartPage(),
    };
  }
}
