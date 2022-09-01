import 'package:flutter/material.dart';
import 'package:flutter101/core/di/cart_controller.dart';
import 'package:flutter101/core/enum/shopping_cart_mode.dart';
import 'package:flutter101/core/themes/light_color.dart';
import 'package:flutter101/core/themes/theme.dart';
import 'package:flutter101/core/widgets/custom_app_bar.dart';
import 'package:flutter101/core/widgets/extentions.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({Key? key,
    required this.headLine1,
    required this.headLine2,
    this.mode = ShoppingCartMode.normal,
    this.isShop = false,  this.onPressedIcon})
      : super(key: key);

  final String headLine1;
  final String headLine2;
  final bool isShop;
  final ShoppingCartMode mode;
  final Function? onPressedIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CustomAppBar(
          title: 'MainPage AppBar',
        ),
        _title(),
      ],
    );
  }

  Widget _title() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                headLine1,
                style: GoogleFonts.mulish(
                    fontSize: 27,
                    fontWeight: FontWeight.w400,
                    color: LightColor.titleTextColor),
              ),
              Text(
                headLine2,
                style: GoogleFonts.mulish(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    color: LightColor.titleTextColor),
              ),
            ],
          ),
          isShop && Get
              .find<CartController>()
              .carList
              .isNotEmpty
              ? Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              mode == ShoppingCartMode.normal ? Icons.edit_outlined : Icons
                  .close_outlined,
              color: LightColor.orange,
            ),
          ).ripple(() {
            if (onPressedIcon != null){
              onPressedIcon!();
            }
          },
              borderRadius: const BorderRadius.all(Radius.circular(13)))
              : Container()
        ],
      ),
    );
  }
}
