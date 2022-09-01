import 'package:flutter/material.dart';
import 'package:flutter101/core/themes/light_color.dart';
import 'package:flutter101/src/pages/login/login_page_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _loginPageController = Get.put(LoginPageController());
  // final _loginPageController = Get.lazyPut<LoginPageController>(() => LoginPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png"),
            _loginWithKeyCloak(),
            _bypassLoginButton(),
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
          _loginPageController.signInWithAutoCodeExchange();
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
        onPressed: () {},
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
}
