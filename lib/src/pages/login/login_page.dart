import 'package:flutter/material.dart';
import 'package:flutter101/core/di/local_controller.dart';
import 'package:flutter101/core/flavor/flavor_config.dart';
import 'package:flutter101/core/local/languages/languages.dart';
import 'package:flutter101/core/themes/light_color.dart';
import 'package:flutter101/src/pages/login/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  late Languages language;
  // final _loginPageController = Get.put(LoginPageController());
  final _authController = Get.find<AuthController>();
  // final _loginPageController = Get.lazyPut<LoginPageController>(() => LoginPageController());
  @override
  Widget build(BuildContext context) {
    language = Languages.of(context)!;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("hello".tr),
            Text("${language.hello}"),
            Image.asset("assets/logo.png"),
            _loginWithKeyCloak(),
            _bypassLoginButton(),
            _updateLocaleTH(),
            _updateLocaleEN(),
            Text("${FlavorConfig.instance.name}"),
            Text("${Get.deviceLocale}")
          ],
        ),
      ),
    );
  }

  Widget _loginWithKeyCloak() {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          _authController.signInWithAutoCodeExchange();
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: LightColor.orange,
            shape: const StadiumBorder(),
            side: const BorderSide(color: LightColor.orange),),
        child: Text(
          "Login with Keycloak",
          style: GoogleFonts.mulish(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: LightColor.orange),
        ),
      ),
    );
  }
  Widget _bypassLoginButton() {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          _authController.bypassLogin();
        },
        style: ElevatedButton.styleFrom(
          primary: LightColor.orange,
          onPrimary: LightColor.orange,
          shape: const StadiumBorder(),
          side: const BorderSide(color: LightColor.orange),),
        child: Text(
          "Bypass login",
          style: GoogleFonts.mulish(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      ),
    );
  }

  Widget _updateLocaleTH() {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          // var locale = const Locale('hi','IN');
          // Get.updateLocale(locale);
          Get.find<LocalController>().changeLanguage('th');
        },
        style: ElevatedButton.styleFrom(
          primary: LightColor.orange,
          onPrimary: LightColor.orange,
          shape: const StadiumBorder(),
          side: const BorderSide(color: LightColor.orange),),
        child: Text(
          "Update Locale TH",
          style: GoogleFonts.mulish(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      ),
    );
  }
  Widget _updateLocaleEN() {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          // var locale = const Locale('hi','IN');
          // Get.updateLocale(locale);
          Get.find<LocalController>().changeLanguage('en');
        },
        style: ElevatedButton.styleFrom(
          primary: LightColor.orange,
          onPrimary: LightColor.orange,
          shape: const StadiumBorder(),
          side: const BorderSide(color: LightColor.orange),),
        child: Text(
          "Update Locale EN",
          style: GoogleFonts.mulish(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      ),
    );
  }
}
