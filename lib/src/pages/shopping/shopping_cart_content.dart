import 'package:flutter/material.dart';
import 'package:flutter101/core/di/cart_controller.dart';
import 'package:flutter101/core/enum/shopping_cart_mode.dart';
import 'package:flutter101/core/themes/light_color.dart';
import 'package:flutter101/core/themes/theme.dart';
import 'package:flutter101/src/model/cart_item.dart';
import 'package:flutter101/src/pages/shopping/shopping_cart_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingCartContent extends StatelessWidget {
  ShoppingCartContent({Key? key}) : super(key: key);

  final _cartController = Get.find<CartController>();
  final _shoppingCartPageController = Get.find<ShoppingCartPageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.padding,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _cartItem(),
            const Divider(
              thickness: 1,
              height: 70,
            ),
            _price(),
            const SizedBox(
              height: 30,
            ),
            _submittButtom(context)
          ],
        ),
      ),
    );
  }

  Widget _cartItem() {
    return SizedBox(
      height: AppTheme.fullHeight(Get.context!) * 0.5,
      child: _cartController.cartTotal > 0
          ? GetBuilder<CartController>(builder: (controller) {
              return ListView.builder(
                  itemCount: _cartController.cartTotal,
                  itemBuilder: (ctx, index) {
                    return _item(_cartController.carList[index]);
                  });
            })
          : Center(
              child: Text(
                "Cart is empty",
                style: GoogleFonts.mulish(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: LightColor.grey),
              ),
            ),
    );

    // return Column(
    //   children: AppData.cartList.map((e) => _item(e)).toList(),
    // );
  }

  Widget _price() {
    return Visibility(
      visible: _shoppingCartPageController.shoppingCartMode ==
          ShoppingCartMode.normal,
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${_cartController.cartTotal} Items ",
            style: GoogleFonts.mulish(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: LightColor.grey),
          ),
          Text(
            "\$${_cartController.getPrice()}",
            style: GoogleFonts.mulish(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: LightColor.black),
          ),
        ],
      ),
    );
  }

  Widget _submittButtom(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            if (_cartController.cartTotal > 0) {
              if (_shoppingCartPageController.shoppingCartMode ==
                  ShoppingCartMode.normal) {
              } else {
                _cartController.deleteItemToCart();
              }
            }
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              backgroundColor: _cartController.cartTotal > 0
                  ? MaterialStateProperty.all(LightColor.orange)
                  : MaterialStateProperty.all(LightColor.grey)),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 4),
            width: AppTheme.fullWidth(context) * .75,
            child: Text(
              _shoppingCartPageController.shoppingCartMode ==
                      ShoppingCartMode.normal
                  ? "Buy"
                  : "Remove Select items",
              style: GoogleFonts.mulish(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: LightColor.background),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        // _submittButtomWithElevated(context)
      ],
    );
  }

  Widget _item(CartItem e) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          if (_shoppingCartPageController.shoppingCartMode ==
              ShoppingCartMode.delete)
            Checkbox(
              value: e.isSelect,
              activeColor: LightColor.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onChanged: (value) {
                _cartController.setSelected(e, value!);
              },
            ),
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: Container(
                      decoration: BoxDecoration(
                          color: LightColor.lightGrey,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Positioned(
                    left: -20,
                    bottom: -20,
                    child: Image.asset(
                      e.product.image,
                      height: 114,
                      width: 127,
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                e.product.name,
                style: GoogleFonts.mulish(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: LightColor.black),
              ),
              subtitle: Row(
                children: [
                  Text(
                    "\$",
                    style: GoogleFonts.mulish(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: LightColor.orange),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    e.product.price.toString(),
                    style: GoogleFonts.mulish(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: LightColor.black),
                  ),
                ],
              ),
              trailing: _shoppingCartPageController.shoppingCartMode ==
                      ShoppingCartMode.normal
                  ? Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: LightColor.lightGrey,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        "x${e.quantity}",
                        style: GoogleFonts.mulish(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: LightColor.black),
                      ),
                    )
                  : SizedBox(),
            ),
          )
        ],
      ),
    );
  }

  Widget _submittButtomWithElevated(BuildContext context) {
    return SizedBox(
      width: 318,
      height: 46,
      child: ElevatedButton(
        onPressed: () {},
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
            "But",
            style: GoogleFonts.mulish(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: LightColor.background),
          ),
        ),
      ),
    );
  }
}
