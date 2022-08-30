import 'package:flutter/material.dart';
import 'package:flutter101/src/model/data.dart';
import 'package:flutter101/src/model/category.dart';
import 'package:flutter101/src/model/product.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class MainController extends GetxController {
  List<Category> categoryList = [];
  List<Product> productList = [];

  @override
  void onReady() {
    _fetchPricudtAndCatagory();

    super.onReady();
  }

  var countRx = 0.obs;
  var count = 0.obs;

  incrementRx() {
    countRx++;
    print(countRx);
    // update();
  }

  increment() {
    count++;
    print(count);
    update();
  }

  void _fetchPricudtAndCatagory() async {
    Get.dialog(
      AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: const Text("Loading. . ."),
            )
          ],
        ),
      ),
      barrierDismissible: false
    );

    final response = await Future.wait(
      [
        AppData.simulateFetchingProduct(),
        AppData.simulateFetchingCaralog(),
      ],
    );

    categoryList = response[1] as List<Category>;
    productList = response[0] as List<Product>;

    Navigator.of(Get.overlayContext!).pop();

    update();
  }

  Category? getSelectedCategory() {
    try {
      return categoryList.firstWhere((element) => element.isSelected);
    } catch (e) {
      return null;
    }
  }

  void updateCategorySelected(Category category) {
    final selectedCategory = getSelectedCategory();
    selectedCategory?.isSelected = false;
    category.isSelected = true;

    final productListByCategory = productList
        .where((element) => element.category == category.name)
        .toList();
    updateProductSelected(productListByCategory[0]);
  }

  void updateProductSelected(Product product) {
    final selectedProduct = getSelectedProduct();
    selectedProduct?.isSelected = false;
    product.isSelected = true;

    update();
  }

  Product? getSelectedProduct() {
    try {
      return productList.firstWhere((element) => element.isSelected);
    } catch (e) {
      return null;
    }
  }
}
