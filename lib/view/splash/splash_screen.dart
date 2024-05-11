import 'package:flutter/material.dart';
import '../../res/constants/app_color.dart';
import '../../res/constants/value.dart';
import '../../view_model/splash/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashScreen = SplashController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColor,
      body: Center(
          child: Text(
        'Welcome to MegaMind Bot',
        style: TextStyle(color: white, fontSize: fontBig),
      )),
    );
  }
}
