import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
import 'package:tasky_apis/core/cache_helper.dart';

class AuthHelper {
  static String _token = "0";
  static String _refreshToken = "0";

  static get authorization => "Bearer $_token";
  static get refreshToken => _refreshToken;

  AuthHelper();

  static Future<void> init() async {
    if (!CacheHelper.instance!.containsKey("token")) {
      await CacheHelper.create("token", "0");
    }
    if (!CacheHelper.instance!.containsKey("refresh_token")) {
      await CacheHelper.create("refresh_token", "0");
    }
  }

  static void _refresh() {
    _token = CacheHelper.read("token");
    _refreshToken = CacheHelper.read("refresh_token");
  }

  static bool isAuthenticated() {
    _refresh();
    return _token != "0" ? true : false;
  }

  static Future<bool> authenticate(String token, {String? refreshToken}) async {
    bool state2 = await CacheHelper.create("token", token);
    bool state1 = true;

    if (refreshToken != null) {
      state1 = await CacheHelper.create("refresh_token", refreshToken);
    }

    _refresh();
    return state1 && state2;
  }

  static Future<bool> unauthenticate() async {
    bool state1 = await CacheHelper.create("token", "0");
    bool state2 = await CacheHelper.create("refresh_token", "0");

    _refresh();
    return state1 && state2;
  }

  static bool routeAuthenticatedUser(
      BuildContext context, void Function() vcb) {
    // Logger().e("The token is $token and The refresh is $refreshToken");
    if (isAuthenticated()) {
      Navigator.pushReplacementNamed(context, "tasks");
      return true;
    } else {
      vcb();
      return false;
    }
  }
}
