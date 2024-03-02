import 'dart:convert';
import 'dart:typed_data';

import 'package:YOBO_Bot/res/constants/value.dart';
import 'package:YOBO_Bot/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../model/message.dart';
import '../dashboad/dashboard_view_model.dart';
import '../home/home_view_models.dart';

class AnalyticsViewModel extends GetxController {
  RxList dateList = [].obs;
  final FirebaseStorage storage = FirebaseStorage.instance;
  DashboardViewModel homeViewModel = Get.find();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listAnalyticsDate();
  }

  Future<void> listAnalyticsDate() async {
    dateList.clear();
    final storageRef = storage.ref().child("/logs/${homeViewModel.mac.value}");
    final listResult = await storageRef.listAll();
    for (Reference item in listResult.items) {
      // The items under storageRef.
      dateList.add(item.fullPath);
    }
  }

  Future<List<Message>> downloadJson(String path) async {
    Utils.showLoading("Loading data...");
    final islandRef = storage.ref().child(path);
    List<Message> list = [];
    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await islandRef.getData(oneMegabyte);
      String s = String.fromCharCodes(data!);
      for (var d in jsonDecode(s)) {
        list.add(Message.fromJson(d));
      }
    } on FirebaseException catch (e) {
      // Handle any errors.
      Utils.hidePopup();
      Utils.showSnackBar(e.message.toString());
    }
    Utils.hidePopup();
    return list;
  }
}
