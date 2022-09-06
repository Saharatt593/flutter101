import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter101/core/config/routes.dart';
import 'package:flutter101/core/di/cart_controller.dart';
import 'package:flutter101/core/themes/light_color.dart';
import 'package:flutter101/core/widgets/custom_confirm_dialog.dart';
import 'package:flutter101/core/widgets/header.dart';
import 'package:flutter101/src/pages/login/auth_controller.dart';
import 'package:flutter101/src/pages/main/main_contriller.dart';
import 'package:flutter101/src/pages/main/widgets/main_content.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await showDialog(
            context: context,
            builder: (ctx) {
              return CustomConfirmDialog(
                title: "ยืนยันปิดแอปพลิเคชั่น ?",
                description: "",
                positiveText: "ยืนยัน",
                negativeText: "ยกเลิก",
                assetImage: "assets/logout.svg",
                positiveHandler: () async {
                  Get.find<AuthController>().endSession();


                  // Get.offAllNamed(Routes.rootPage);

                  // if(Platform.isIOS){
                  //   try{
                  //     exit(0);
                  //   } catch( e ){
                  //     SystemNavigator.pop();
                  //   }
                  // }else{
                  //   try{
                  //     SystemNavigator.pop();
                  //   } catch( e ){
                  //     exit(0);
                  //   }
                  // }
                },
                negativeHandler: () async {},
              );
            });

        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Header(headLine1: "Our", headLine2: "Products"),
              Expanded(child: MainContent()),
            ],
          ),
        ),
        floatingActionButton: _flotingButton(context),
      ),
    );
  }

  Widget _flotingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // _mainController.increment();
        // _mainController.incrementRx();

        // Navigator.of(context).pushNamed(Routes.shoppingCartPage);

        Get.toNamed(Routes.shoppingCartPage);
      },
      backgroundColor: LightColor.orange,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Align(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Icon(Icons.shopping_basket,
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor),
              ),
              Positioned(
                right: 8,
                top: 8,
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
                  // child: Obx(() => Text(
                  //       "${_mainController.countRx}",
                  //       style: GoogleFonts.mulish(
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w700,
                  //           color: LightColor.orange),
                  //     )),

                  child: GetBuilder<CartController>(
                    builder: (CartController controller) {
                      return Text(
                        "${controller.cartTotal}",
                        style: GoogleFonts.mulish(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: LightColor.orange),
                      );
                    },
                  ),

                  // child: GetX<MainController>(
                  //   init: _mainController,
                  //   builder: (MainController controller){
                  //     return Text(
                  //       "${controller.countRx}",
                  //       style: GoogleFonts.mulish(
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w700,
                  //           color: LightColor.orange),
                  //     );
                  //   },
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
