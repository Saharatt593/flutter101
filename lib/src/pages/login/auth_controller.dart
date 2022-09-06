import 'package:flutter/foundation.dart';
import 'package:flutter101/core/config/routes.dart';
import 'package:flutter101/core/config/shared_preferences_key.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  final String _clientId = 'mobile';
  final String _redirectUrl = 'dolappeal://auth';
  final List<String> _scopes = <String>['openid', 'email', 'profile'];

  /// ข้อมูล url ต่างๆมาจาก Keycloak : https://apidcdev.dol.go.th/auth/realms/master/.well-known/openid-configuration
  final AuthorizationServiceConfiguration _serviceConfiguration =
  const AuthorizationServiceConfiguration(
    authorizationEndpoint:
    'https://apidcdev.dol.go.th/auth/realms/master/protocol/openid-connect/auth',
    tokenEndpoint:
    'https://apidcdev.dol.go.th/auth/realms/master/protocol/openid-connect/token',
    endSessionEndpoint:
    'https://apidcdev.dol.go.th/auth/realms/master/protocol/openid-connect/logout',
  );

  /// Test user : thitima.n
  Future<void> signInWithAutoCodeExchange(
      {bool preferEphemeralSession = false}) async {
    try {
      /// ถ้าเคย Login จะได้ Token กลับมาเลยไม่แสดงหน้า Login ให้ผู้ใช้กรอก User/Pass อีก
      // show that we can also explicitly specify the endpoints rather than getting from the details from the discovery document
      // final AuthorizationTokenResponse? result =
      // await _appAuth.authorizeAndExchangeCode(
      //   AuthorizationTokenRequest(
      //     _clientId,
      //     _redirectUrl,
      //     serviceConfiguration: _serviceConfiguration,
      //     scopes: _scopes,
      //     preferEphemeralSession: preferEphemeralSession,
      //   ),
      // );

      /// แบบนี้จะเป้นการ Force user ไปหน้า Login ถึงแม้ จะเคย Login แล้ว
      // this code block demonstrates passing in values for the prompt parameter. in this case it prompts the user login even if they have already signed in. the list of supported values depends on the identity provider
      final AuthorizationTokenResponse? result =
      await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(_clientId, _redirectUrl,
            serviceConfiguration: _serviceConfiguration,
            scopes: _scopes,
            promptValues: ['login']),
      );

      if (result != null) {
        _processAuthTokenResponse(result);
      }
    } catch (_) {
      // TODO : Do stuff with error
    }
  }

  void _processAuthTokenResponse(AuthorizationTokenResponse result) async {
    final prefs = await SharedPreferences.getInstance();
    if (result.accessToken?.isNotEmpty == true &&
        result.refreshToken?.isNotEmpty == true &&
        result.idToken?.isNotEmpty == true
    ) {
      await prefs.setString(
          SharedPreferencesKey.KEY_ACCESS_TOKEN, result.accessToken!);
      await prefs.setString(
          SharedPreferencesKey.KEY_REFRESH_TOKEN, result.refreshToken!);
      await prefs.setString(
          SharedPreferencesKey.KEY_TOKEN_ID, result.idToken!);

      final String? action =
      prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOKEN);
      print(action);

      Get.offAllNamed(Routes.mainPage);
    }
    // TODO : Save token to SharedPreference
  }

  void bypassLogin() {
    Get.offAllNamed(Routes.mainPage);
  }

  void endSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? tokenId = prefs.getString(
          SharedPreferencesKey.KEY_TOKEN_ID);
      if (tokenId?.isNotEmpty == true) {
        await _appAuth.endSession(EndSessionRequest(
            idTokenHint:tokenId,
            postLogoutRedirectUrl: _redirectUrl,
            serviceConfiguration: _serviceConfiguration));
      }

      await SharedPreferencesKey.clearAll();
      Get.offAllNamed(Routes.rootPage);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
