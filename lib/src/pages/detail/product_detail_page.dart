import 'package:flutter/material.dart';
import 'package:flutter101/core/config/routes.dart';
import 'package:flutter101/core/di/cart_controller.dart';
import 'package:flutter101/core/enum/available_color.dart';
import 'package:flutter101/core/enum/available_size.dart';
import 'package:flutter101/core/themes/light_color.dart';
import 'package:flutter101/core/themes/theme.dart';
import 'package:flutter101/core/widgets/extentions.dart';
import 'package:flutter101/src/model/cart_item.dart';
import 'package:flutter101/src/model/data.dart';
import 'package:flutter101/src/pages/detail/product_detail_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({Key? key}) : super(key: key);

  final _productDetailController = Get.put(ProductDetailController());
  final _cartController = Get.find<CartController>();

  // @override
  // void didChangeDependencies() {
  //   final arg = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
  //   print(arg);
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(color: LightColor.lightGrey),
        child: Stack(
          children: [
            Column(
              children: [
                _appBar(context),
                _productImage(),
                _imageThumbnail(),
              ],
            ),
            _detailWidget(),
            _submittButtomWithElevated(context)
          ],
        ),
      )),
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
        maxChildSize: .8,
        initialChildSize: .53,
        minChildSize: .53,
        builder: (context, scrollController) {
          return Container(
            padding: AppTheme.padding.copyWith(bottom: 0),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                controller: scrollController,
                // physics: const BouncingScrollPhysics(),
                child: _buttomsheetContent(context),
              ),
            ),
          );
        });
  }

  Widget _buttomsheetContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          width: 50,
          height: 5,
          decoration: const BoxDecoration(
            color: LightColor.iconColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _productDetailController.produc.name.toString(),
              style: GoogleFonts.mulish(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: LightColor.titleTextColor),
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$",
                      style: GoogleFonts.mulish(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: LightColor.orange),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      _productDetailController.produc.price.toString(),
                      style: GoogleFonts.mulish(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: LightColor.titleTextColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: const [
                    Icon(Icons.star, color: LightColor.yellowColor, size: 17),
                    Icon(Icons.star, color: LightColor.yellowColor, size: 17),
                    Icon(Icons.star, color: LightColor.yellowColor, size: 17),
                    Icon(Icons.star, color: LightColor.yellowColor, size: 17),
                    Icon(Icons.star, color: LightColor.lightGrey, size: 17),
                  ],
                )
              ],
            ),
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Available Sizes",
            style: GoogleFonts.mulish(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: LightColor.titleTextColor),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GetBuilder<ProductDetailController>(builder: (controller) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: controller.availableSize
                .map((e) =>
                    _sizeWidget(e, isSelected: e == controller.selectSize))
                .toList(),
          );
        }),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "Color",
              style: GoogleFonts.mulish(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: LightColor.titleTextColor),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        GetBuilder<ProductDetailController>(builder: (controller) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: controller.availableColor
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: _colorWidget(e,
                          isSelected: e == controller.selectColor),
                    ),
                  )
                  .toList());
        }),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Text(
              "Description",
              style: GoogleFonts.mulish(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: LightColor.titleTextColor),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "xxxxxxxxxxxxxxxxxxxxxxxxx",
              style: GoogleFonts.mulish(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: LightColor.titleTextColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _colorWidget(AvailableColor color, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        _productDetailController.setSeletedColor(color);
      },
      child: CircleAvatar(
        radius: 12,
        backgroundColor: color.color.withAlpha(150),
        child: isSelected
            ? Icon(
                Icons.check_circle,
                color: color.color,
                size: 18,
              )
            : CircleAvatar(radius: 7, backgroundColor: color.color),
      ),
    );
  }

  Widget _sizeWidget(AvailableSize size, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: !isSelected ? BorderStyle.solid : BorderStyle.none),
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        color: isSelected ? LightColor.orange : Colors.transparent,
      ),
      child: Text(size.name,
          style: GoogleFonts.mulish(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color:
                isSelected ? LightColor.background : LightColor.titleTextColor,
          )),
    ).ripple(() {
      _productDetailController.setSeletedSize(size);
    }, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }

  Widget _appBar(BuildContext context) {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _icon(
            Icons.arrow_back_ios,
            context,
            color: Colors.black45,
            size: 12,
            padding: 12,
            borderColor: LightColor.darkgrey,
            isOutline: true,
            action: () {
              // Navigator.of(context).pop();

              Get.back();
            },
          ),
          Stack(
            children: [
              _icon(Icons.shopping_basket, context,
                  color: LightColor.grey, size: 15, padding: 12
              ,action: (){
                    Get.toNamed(Routes.shoppingCartPage);
                  }),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 22,
                  height: 22,
                  padding: const EdgeInsets.only(left: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                    color: LightColor.orange,
                  ),
                  child: GetBuilder<CartController>(builder: (controller) {
                    return Text(
                      "${controller.cartTotal}",
                      style: GoogleFonts.mulish(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    );
                  }),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _icon(IconData icon, BuildContext context,
      {double padding = 10,
      Color color = LightColor.iconColor,
      double size = 5,
      Color borderColor = LightColor.lightGrey,
      bool isOutline = false,
      Function? action}) {
    return Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          style: isOutline ? BorderStyle.solid : BorderStyle.none,
          // style:
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color:
            isOutline ? Colors.transparent : Theme.of(context).backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: LightColor.lightGrey,
            blurRadius: 5,
            spreadRadius: 10,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: icon == Icons.arrow_back_ios ? 0 : 1,
        ),
        child: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    ).ripple(() {
      if (action != null) {
        action();
      }
    }, borderRadius: const BorderRadius.all(Radius.circular(10)));
  }

  Widget _productImage() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Text(
          "AIR",
          style: GoogleFonts.mulish(
              fontSize: 160,
              fontWeight: FontWeight.w700,
              color: LightColor.grey),
        ),
        Image.asset("assets/show_1.png")
      ],
    );
  }

  Widget _imageThumbnail() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              AppData.showThumbnailList.map((e) => _thumbnail(e)).toList(),
        ));
  }

  Widget _thumbnail(iamge) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: LightColor.grey,
          )),
      height: 40,
      width: 50,
      child: Image.asset(iamge),
    );
  }

  Widget _submittButtomWithElevated(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 318,
        height: 46,
        child: ElevatedButton(
          onPressed: () {
            _cartController.addItemToCart(
              CartItem(
                  _productDetailController.produc,
                  _productDetailController.selectColor,
                  _productDetailController.selectSize),
            );

            Fluttertoast.showToast(
                msg: "Add to Cart",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              backgroundColor: MaterialStateProperty.all(LightColor.orange)),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 4),
            width: AppTheme.fullWidth(context) * .75,
            child: Text(
              "Add to Cart",
              style: GoogleFonts.mulish(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: LightColor.background),
            ),
          ),
        ),
      ),
    );
  }
}
