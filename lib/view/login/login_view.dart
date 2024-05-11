import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../res/components/common_widgets.dart';
import '../../res/constants/app_color.dart';
import '../../view_model/login_register/login_view_model.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  LoginRegViewModel loginRegViewModel = Get.put(LoginRegViewModel());

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 38,
                    ),
                  ),
                  const Text(
                    'Login now to control our device',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  normalTextField(
                      loginRegViewModel.emailController.value, "Email",
                      prefIcon: const Icon(Icons.email)),
                  const SizedBox(
                    height: 30,
                  ),
                  normalTextField(
                      loginRegViewModel.passwordController.value, "Password",
                      prefIcon: const Icon(Icons.lock)),
                  Container(
                    width: double.infinity,
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                        child: const Text(
                          "forget your password",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {}),
                  ),
                  normalButton("LOGIN", primaryColor, white, onPressed: () {
                    loginRegViewModel
                        .loginWithEmailPassword()
                        .whenComplete(() {});
                  }),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 2,
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            "OR Sign With",
                          )),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: IconButton(
                        onPressed: () {
                          loginRegViewModel.signInWithGoogle();
                        },
                        icon: const Icon(FontAwesomeIcons.google,
                            size: 35, color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
