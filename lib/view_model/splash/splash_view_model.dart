import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../res/routes/routes_name.dart';

class SplashController {
  void isLogin() {
    /// Check login status and view page
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Timer(
          const Duration(seconds: 2), () => Get.offNamed(RouteName.loginView));
    } else {
      Timer(
          const Duration(seconds: 2), () => Get.offNamed(RouteName.dashBoard));
    }
  }
}
