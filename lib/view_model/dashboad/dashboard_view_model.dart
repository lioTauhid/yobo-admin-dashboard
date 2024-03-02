import 'package:get/get.dart';
import '../../repository/dashboard_repo/dash_repo.dart';

class DashboardViewModel extends GetxController {
  final _repo = DashboardRepo();
  RxString mac = "".obs;
  RxString tag = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMacAddress();
  }

  Future<void> saveMacAddress(String macAddress) async {
    await _repo.setMacToPref(macAddress);
    mac.value = macAddress;
  }

  Future<void> getMacAddress() async {
    String? macAddress = await _repo.getMac();
    mac.value = macAddress!;
  }

  Future<void> logout() async {
    await _repo.clearSession();
  }
}
