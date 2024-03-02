import 'package:get/get.dart';

import '../../repository/home_repository/home_repo.dart';

class HomeViewModel extends GetxController {
  final _repo = HomeRepo();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void rebootDevice(String mac){
    _repo.reboot(mac);
  }
}
