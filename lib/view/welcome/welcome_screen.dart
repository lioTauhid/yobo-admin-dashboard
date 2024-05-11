import 'package:YOBO_Bot/res/components/custom_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../res/components/common_widgets.dart';
import '../../res/constants/app_color.dart';
import '../../res/constants/value.dart';
import '../../utils/utils.dart';
import '../../view_model/welcome/welcome_view_model.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final WelcomeViewModel welcomeViewModel = Get.put(WelcomeViewModel());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (kIsWeb) {
      size = size / 3;
    }
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: kIsWeb ? size.width / 1.3 : 0, vertical: 20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: primaryColor),
          borderRadius: BorderRadius.circular(30),
          color: primaryColor),
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Center(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.fill,
                    height: 150,
                    width: 160,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to MegaMind Bot',
                  style: TextStyle(color: white, fontSize: fontVeryBig),
                ),
                const SizedBox(height: 10),
                const Text(
                  'First an account need to control,\n configure and see analytics\n in our device',
                  style: TextStyle(fontSize: 18, color: white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 80),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: normalButton("Sign-up with Google", secondaryColor,
                      primaryColor, FontAwesomeIcons.google, onPressed: () {
                    showCustomDialog(
                        context,
                        "Enter Invitation Code",
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              normalTextField(welcomeViewModel.controllerCode,
                                  "* Invitation Code",
                                  prefIcon: const Icon(Icons.numbers)),
                              const SizedBox(height: 15),
                              // normalTextField(
                              //     welcomeViewModel.controllerEmail, "Email",
                              //     prefIcon: const Icon(Icons.email)),
                              const SizedBox(height: 15),
                              normalButton(
                                  "Submit",
                                  secondaryColor,
                                  primaryColor,
                                  FontAwesomeIcons.arrowRight, onPressed: () {
                                Utils.showLoading("Please wait...checking");
                                welcomeViewModel
                                    .checkCode(
                                        welcomeViewModel.controllerCode.text)
                                    .then((value) {});
                              }),
                            ],
                          ),
                        ),
                        kIsWeb? size.height / 3:100,
                        kIsWeb? size.width * 1.6:30);
                  }),
                ),
                const SizedBox(height: 15),
                const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "OR Login",
                      style:
                          TextStyle(color: secondaryColor, fontSize: fontSmall),
                    )),
                const SizedBox(height: 15),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: normalButton("Login with Google", secondaryColor,
                      primaryColor, FontAwesomeIcons.google, onPressed: () {
                    welcomeViewModel.signInWithGoogle(context);
                  }),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget normalButton(
      String text, Color background, Color textColor, IconData iconData,
      {Function()? onPressed}) {
    return MaterialButton(
        elevation: 0,
        color: background,
        height: 45,
        minWidth: 150,
        padding: const EdgeInsets.all(10),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(400.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: fontMedium),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(iconData, size: 30, color: Colors.blue))
          ],
        ));
  }
}
