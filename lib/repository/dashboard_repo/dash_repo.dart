import 'package:YOBO_Bot/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../service/local/shared_pref.dart';
import '../../service/network/firebase_realtime.dart';

class DashboardRepo {
  SharedPref sharedPref = SharedPref();
  FirebaseRealTime db = FirebaseRealTime();
  final auth = FirebaseAuth.instance;

  Future<void> setMacToPref(String macAddress) async {
    await sharedPref.saveValue("macAddress", macAddress).then((value) async {
      Utils.showSnackBar("Dashboard switched to. $macAddress");
    });
  }

  Future<String?> getMac() async {
    return await sharedPref.getValue("macAddress");
  }

  Future<void> clearSession() async {
    await sharedPref.saveValue("macAddress", '');
    await auth.signOut();
  }
}
