import 'package:YOBO_Bot/res/constants/value.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../service/local/shared_pref.dart';
import '../../service/network/firebase_realtime.dart';

class HomeRepo {
  SharedPref sharedPref = SharedPref();
  FirebaseRealTime db = FirebaseRealTime();
  final user = FirebaseAuth.instance.currentUser;


  Future<void> reboot(String mac) async {
    await db.saveToDb("devices/$mac/reboot/", "on");
  }
}
