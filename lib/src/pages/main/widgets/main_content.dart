import 'package:flutter/material.dart';
import 'package:flutter101/core/config/routes.dart';
import 'package:flutter101/core/themes/light_color.dart';
import 'package:flutter101/core/themes/theme.dart';
import 'package:flutter101/core/widgets/extentions.dart';
import 'package:flutter101/src/model/data.dart';
import 'package:flutter101/src/pages/main/main_contriller.dart';
import 'package:flutter101/src/pages/main/widgets/category_item.dart';
import 'package:flutter101/src/pages/main/widgets/product_item.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class MainContent extends StatelessWidget {
  MainContent({Key? key}) : super(key: key);

  final _mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        // แนวของ ScrollView
        scrollDirection: Axis.vertical,
        // true = เมื่อเปิดหน้าจะแสดงเนื้อหา บนสุด ของ ScrollView
        // false = เมื่อเปิดหน้าจะแสดงเนื้อหาบน ล่างสุด ของ ScrollView
        reverse: false,
        // NeverScrollableScrollPhysics - ทำให้ ScrollView ไม่สามารถเลื่อนได้
        // BouncingScrollPhysics - ปิด overscroll effect
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _search(context),
            _categoryWidgetLitView(context),
            _productList(context),
          ],
        ),
      ),
    );
  }

  Widget _search(BuildContext context) {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: _textField(),
          ),
          const SizedBox(width: 20),
          _icon(
            context,
            Icons.filter_list,
            color: Colors.black54,
          ),
          _icon(
            context,
            Icons.image,
            color: Colors.black54,
          ).ripple(() {
            Get.toNamed(Routes.picture);
          }),
        ],
      ),
    );
  }

  Widget _icon(BuildContext context, IconData icon,
      {Color color = LightColor.iconColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {
      _mainController.get();
    }, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }

  Widget _textFieldShowcase() {
    return TextField(
      readOnly: false,
      // สามารถ Highlight คัดลอกข้อความได้ ยังสามารถ Focus ได้ แต่ไม่สามารถแก้ไขได้
      enabled: false,
      // ไม่สามารถเข้าถึงข้อความได้เลย
      obscureText: false,
      textAlign: TextAlign.start,
      textInputAction: TextInputAction.search,
      // Not working in hot reload
      autofocus: false,
      // Not working in hot reload
      maxLength: 5,
      onChanged: (value) {
        print("Typing... : ${value}");
      },
      onSubmitted: (value) {
        print("Submitting... : ${value}");
      },
      decoration: InputDecoration(
        // label: const Text("ค้นหา 1"),
        labelText: "ค้นหา 2",
        labelStyle: AppTheme.h6Style,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        hintText: "ค้นหา 3",
        hintStyle: AppTheme.h6Style,
        prefixIcon: const Icon(Icons.search, color: Colors.black54),
        suffixIcon: const Icon(Icons.search, color: Colors.black54),
        contentPadding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.green,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(24.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: Colors.green,
          ),
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }

  Widget _textField() {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: LightColor.lightGrey.withAlpha(100),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: _mainController.searchController,
        onSubmitted: (_) {
          _mainController.searchAuto();
        },
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Search Products",
            hintStyle: TextStyle(fontSize: 12),
            contentPadding:
                EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
            prefixIcon: Icon(Icons.search, color: Colors.black54)),
      ),
    );
  }

  Widget _categoryWidgetLitView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 80,
      // เหมาะสำหรับ List ขนาดเล็ก สร้าง View ขึ้นมาถึงแม้ไม่ถูกแสดงบนหน้าจอ
      child: GetBuilder<MainController>(builder: (MainController controller) {
        return ListView(
          scrollDirection: Axis.horizontal,
          reverse: false,
          children: controller.categoryList
              .map(
                (category) =>
                    CategoryItem(category: category, onSelected: _onSelected),
              )
              .toList(),
        );
      }),
    );
  }

  Widget _categoryWidgetLitViewBuilder(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        reverse: false,
        itemCount: AppData.categoryList.length,
        itemBuilder: (ctx, index) {
          final category = AppData.categoryList[index];
          return CategoryItem(category: category);
        },
      ),
    );
  }

  _productWidgetFixedColumn(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .7,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 3,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20),
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.vertical,
        reverse: false,
        children: AppData.productList
            .map(
              (product) => Container(
                color: Colors.amber,
                child: Center(child: Text(product.id.toString())),
              ),
            )
            .toList(),
      ),
    );

    // Shorthand with name parameter
    // return Container(
    //   margin: const EdgeInsets.symmetric(vertical: 10),
    //   width: AppTheme.fullWidth(context),
    //   height: AppTheme.fullWidth(context) * .7,
    //   child: GridView.count(
    //     crossAxisCount: 2,
    //     childAspectRatio: 4 / 3,
    //     mainAxisSpacing: 30,
    //     crossAxisSpacing: 20,
    //     padding: const EdgeInsets.only(left: 20, right: 20),
    //     scrollDirection: Axis.vertical,
    //     reverse: false,
    //     children: AppData.productList
    //         .map(
    //           (product) => Container(
    //             color: Colors.amber,
    //             child: Center(child: Text(product.id.toString())),
    //           ),
    //         )
    //         .toList(),
    //   ),
    // );
  }

  _productWidgetMaxCrossAxisExtent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .7,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 4 / 3,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20),
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.vertical,
        reverse: false,
        children: AppData.productList
            .map(
              (product) => Container(
                color: Colors.blue,
                child: Center(child: Text(product.id.toString())),
              ),
            )
            .toList(),
      ),
    );

    // Shorthand with name parameter
    // return Container(
    //   margin: const EdgeInsets.symmetric(vertical: 10),
    //   width: AppTheme.fullWidth(context),
    //   height: AppTheme.fullWidth(context) * .7,
    //   child: GridView.extent(
    //     maxCrossAxisExtent: 200,
    //     mainAxisSpacing: 30,
    //     crossAxisSpacing: 20,
    //     childAspectRatio: 4 / 3,
    //     padding: const EdgeInsets.only(left: 20, right: 20),
    //     scrollDirection: Axis.vertical,
    //     reverse: false,
    //     children: AppData.productList
    //         .map(
    //           (product) => Container(
    //             color: Colors.blue,
    //             child: Center(child: Text(product.id.toString())),
    //           ),
    //         )
    //         .toList(),
    //   ),
    // );
  }

  _productWidgetGridViewBuilder(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .7,
      child: GridView.builder(
        itemCount: AppData.productList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 3,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20),
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.vertical,
        reverse: false,
        itemBuilder: (ctx, index) {
          return Container(
            color: Colors.amber,
            child:
                Center(child: Text(AppData.productList[index].id.toString())),
          );
        },
      ),
    );
  }

  Widget _productList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .7,
      child: GetBuilder<MainController>(builder: (MainController controller) {
        if (controller.productList.isNotEmpty) {
          return GridView(
            physics: const BouncingScrollPhysics(),
            // Clip to children in Android Native
            clipBehavior: Clip.none,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 4 / 3,
                mainAxisSpacing: 30,
                crossAxisSpacing: 20),
            padding: const EdgeInsets.only(left: 20, right: 20),
            scrollDirection: Axis.horizontal,
            children: controller.productList
                .where((element) =>
                    controller.getSelectedCategory()?.name == element.category)
                .map((product) => ProductItem(
                      product: product,
                      onSelected: _onSelectedProduct,
                    ))
                .toList(),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }

  void _onSelected(dynamic category) {
    _mainController.updateCategorySelected(category);
  }

  void _onSelectedProduct(item) {
    // Navigator.of(context).pushNamed(Routes.detailPage,arguments: {"name":"object"});

    Get.toNamed(Routes.detailPage, arguments: [
      {"item": item}
    ]);

    // Navigator.push(Get.context!, MaterialPageRoute(builder: (context)=> const ProductDetailPage()));
  }
}
