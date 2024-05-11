import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../res/routes/routes_name.dart';
import '../../service/network/api_client.dart';
import '../../utils/utils.dart';

class WelcomeViewModel extends GetxController {
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  User? user;

  ApiClient apiClient = ApiClient();

  Future<void> checkCode(code) async {
    /// check invitation code by api
    var headers = {
      'Authorization': 'W3@cCcP\$wRDD~0',
    };
    // print(headers);
    await apiClient.get("/get-wait-list/$code", header: headers).then((value) {
      Utils.hidePopup();
      // print("case1");
      // print(jsonDecode(value));
      if (jsonDecode(value)["approved"] == 1) {
        singUpWithGoogle();
      } else {
        Utils.showSnackBar(
            "Invitation code is invalid, try with correct code.");
      }
    }).catchError((e) {
      // print("case2");
      // print(e.toString());
      Utils.hidePopup();
      Utils.showSnackBar("Invitation code is invalid, try with correct code.");
    });
  }

  Future<void> singUpWithGoogle() async {
    if (kIsWeb) {
      googleSignIn = GoogleSignIn(
          clientId:
              "594685359786-9qcpce4ptcl00vlha21tmibdv2cm9ula.apps.googleusercontent.com");
    }
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // ...
        } else if (e.code == 'invalid-credential') {
          // ...
        }
      } catch (e) {
        // ...
      }
    }

    if (user != null) {
      Get.offNamed(RouteName.dashBoard);
    }
  }

  void signInWithGoogle(BuildContext context) async {
    if (kIsWeb) {
      googleSignIn = GoogleSignIn(
          clientId:
              "594685359786-9qcpce4ptcl00vlha21tmibdv2cm9ula.apps.googleusercontent.com");
    }
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      if (await checkIfEmailInUse(googleSignInAccount.email)) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // ...
          } else if (e.code == 'invalid-credential') {
            // ...
          }
        } catch (e) {
          // ...
        }
      } else {
        googleSignInAccount.clearAuthCache();
        googleSignIn.signOut();
        Utils.showSnackBar(
            "You have no account to go, Please create account with invitation code first");
      }
    }

    if (user != null) {
      Get.offNamed(RouteName.dashBoard);
    }
  }

  /// Returns true if email address is in use.
  Future<bool> checkIfEmailInUse(String emailAddress) async {
    try {
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty
      if (list.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      // Handle error...
      return true;
    }
  }
}
