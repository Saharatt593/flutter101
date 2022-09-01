import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter101/src/model/data.dart';
import 'package:flutter101/src/model/category.dart';
import 'package:flutter101/src/model/product.dart';
import 'package:flutter101/src/model/product_data.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

class MainController extends GetxController {
  List<Category> categoryList = [];
  List<Product> productList = [];
  List<Product> _oriproductList = [];

  TextEditingController searchController = TextEditingController();

  @override
  void onClose() {
    searchController.dispose();
  }

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
          content: WillPopScope(
            onWillPop: () async => false,
            child: Row(
              children: [
                const CircularProgressIndicator(),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: const Text("Loading. . ."),
                )
              ],
            ),
          ),
        ),
        barrierDismissible: false);

    final response = await Future.wait(
      [
        AppData.simulateFetchingProduct(),
        AppData.simulateFetchingCaralog(),
      ],
    );

    categoryList = response[1] as List<Category>;
    _oriproductList = response[0] as List<Product>;
    productList = _oriproductList;

    Navigator.of(Get.overlayContext!).pop();

    update();
  }

  void search(String search) {
    if (search.isNotEmpty) {
      productList = _filterBySelectCategory(search);
    } else {
      updateCategorySelected(getSelectedCategory()!);
    }

    update();
  }

  void searchAuto() {
    if (searchController.text.isNotEmpty) {
      final list = _filterBySelectCategory(searchController.text);
      if (list.isNotEmpty) {
        _updateProductSelected(list[0]);
      }
      productList = list;
    } else {
      updateCategorySelected(getSelectedCategory()!);
    }

    update();
  }

  List<Product> _filterBySelectCategory(String value) {
    return _getProductListByCategory(getSelectedCategory()!)
        .where((element) => element.name.contains(value))
        .toList();
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

    final productListByCat = searchController.text.isNotEmpty
        ? _filterBySelectCategory(searchController.text)
        : _getProductListByCategory(category);

    productList = productListByCat.toList();

    if (productList.isNotEmpty) {
      _updateProductSelected(productListByCat[0]);
    } else {
      update();
    }

    // final productListByCategory =  _getProductListByCategory(category);
    // productList = productListByCategory.toList();

    // final productListByCategory = productList
    //     .where((element) => element.category == category.name)
    //     .toList();
    // _updateProductSelected(productListByCategory[0]);
  }

  _updateProductSelected(Product product) {
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

  List<Product> _getProductListByCategory(Category category) {
    return _oriproductList
        .where((element) => element.category == category.name)
        .toList();
  }

  void get() async {
    if (await _hasInternet()) {
      Response response;
      var dio = Dio();
      var logger = Logger();
    dio.interceptors.add(InterceptorsWrapper(
      onResponse: (optin,handler) async{
        logger.i(optin.data);
        logger.i(optin.headers);
      }
    ));
// // // customization
//     dio.interceptors.add(LogInterceptor(
//         requestHeader: true,
//         requestBody: true,
//         responseBody: true,
//         responseHeader: false,
//         error: true));

      response = await dio.get('https://jsonblob.com/api/1014809807110291456');
      final data = ProductData.fromJson(response.data);

      print("${data.result!.name}");
    }else{
      print("No Internet");
    }
  }

  Future<bool> _hasInternet() async {
    final connectResult = await Connectivity().checkConnectivity();

    if (connectResult == ConnectivityResult.mobile ||
        connectResult == ConnectivityResult.wifi) {
      return await InternetConnectionChecker().hasConnection;
    }
    return false;
  }
}
