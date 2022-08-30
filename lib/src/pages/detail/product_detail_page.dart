import 'package:flutter/material.dart';
import 'package:flutter101/core/config/routes.dart';
import 'package:flutter101/core/themes/light_color.dart';
import 'package:flutter101/core/themes/theme.dart';
import 'package:flutter101/core/widgets/extentions.dart';
import 'package:flutter101/src/model/data.dart';
import 'package:flutter101/src/pages/detail/product_detail_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({Key? key}) : super(key: key);

  final _productDetailController = Get.put(ProductDetailController());

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
              "NIKE AIR MAX 200",
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
                      "240",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: LightColor.lightGrey,
                ),
              ),
              height: 40,
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "US 6",
                    style: GoogleFonts.mulish(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: LightColor.titleTextColor),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: LightColor.orange,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              height: 40,
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "US 7",
                    style: GoogleFonts.mulish(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: LightColor.lightGrey),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: LightColor.lightGrey,
                  )),
              height: 40,
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "US 8",
                    style: GoogleFonts.mulish(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: LightColor.titleTextColor),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: LightColor.lightGrey,
                  )),
              height: 40,
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "US 9",
                    style: GoogleFonts.mulish(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: LightColor.titleTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundColor: LightColor.orange.withAlpha(40),
                ),
                const CircleAvatar(
                  radius: 10,
                  backgroundColor: LightColor.orange,
                  child: Icon(Icons.check_outlined,
                      color: LightColor.yellowColor, size: 17),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundColor: LightColor.lightBlue.withAlpha(40),
                ),
                const CircleAvatar(
                  radius: 10,
                  backgroundColor: LightColor.lightBlue,
                )
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundColor: LightColor.black.withAlpha(40),
                ),
                const CircleAvatar(
                  radius: 10,
                  backgroundColor: LightColor.black,
                )
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundColor: LightColor.red.withAlpha(40),
                ),
                const CircleAvatar(
                  radius: 10,
                  backgroundColor: LightColor.red,
                )
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundColor: LightColor.skyBlue.withAlpha(40),
                ),
                const CircleAvatar(
                  radius: 10,
                  backgroundColor: LightColor.skyBlue,
                )
              ],
            )
          ],
        ),
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
              Navigator.of(context).pop();
            },
          ),
           Stack(
             children: [
               _icon(Icons.shopping_basket, context,
                  color: LightColor.red, size: 15, padding: 12),
               Positioned(
                 right: -8,
                 top: -8,
                 child: Container(
                   width: 22,
                   height: 22,
                   padding: const EdgeInsets.only(left: 2),
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     border: Border.all(color: LightColor.orange),
                     color: Colors.white,
                   ),
                   child:
                   Text(
                     "1",
                     style: GoogleFonts.mulish(
                         fontSize: 12,
                         fontWeight: FontWeight.w700,
                         color: LightColor.orange),
                   ),
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
      ),
    );
  }
}
