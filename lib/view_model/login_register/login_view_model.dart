import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../res/routes/routes_name.dart';
import '../../utils/utils.dart';

class LoginRegViewModel extends GetxController {
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Firebase.initializeApp().whenComplete(() {});
  }

  Future<void> loginWithEmailPassword() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text);
      if (credential.user != null) {
        Get.offNamed(RouteName.dashBoard);
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message.toString() + e.code);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  Future<void> registerWithEmailPassword() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );
      if (credential.user != null) {
        Get.toNamed(RouteName.dashBoard);
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message.toString() + e.code);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final User? user = (await auth.signInWithCredential(credential)).user;
    if (user != null) {
      Get.offNamed(RouteName.dashBoard);
    }
  }
}
