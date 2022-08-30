import 'package:flutter/material.dart';
import 'package:flutter101/core/themes/light_color.dart';
import 'package:flutter101/core/themes/theme.dart';
import 'package:flutter101/src/model/data.dart';
import 'package:flutter101/src/model/product.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingCartContent extends StatelessWidget {
  const ShoppingCartContent({Key? key}) : super(key: key);

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
    return Column(
      children: AppData.cartList.map((e) => _item(e)).toList(),
    );
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${AppData.cartList.length} Item ",
          style: GoogleFonts.mulish(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: LightColor.grey),
        ),
        Text(
          "\$${AppData.getPrice()}",
          style: GoogleFonts.mulish(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: LightColor.black),
        ),
      ],
    );
  }

  Widget _submittButtom(BuildContext context) {
    return Column(
      children: [
        TextButton(
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
        const SizedBox(
          height: 8,
        ),
        // _submittButtomWithElevated(context)
      ],
    );
  }

  Widget _item(Product e) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
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
                      e.image,
                      height: 114,
                      width: 127,
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                e.name,
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
                    e.price.toString(),
                    style: GoogleFonts.mulish(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: LightColor.black),
                  ),
                ],
              ),
              trailing: Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: LightColor.lightGrey,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  "x${e.id.toString()}",
                  style: GoogleFonts.mulish(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: LightColor.black),
                ),
              ),
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
