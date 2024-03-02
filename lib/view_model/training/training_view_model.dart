import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../dashboad/dashboard_view_model.dart';

class TrainingViewModel extends GetxController {
  RxList dataList = [].obs;
  final FirebaseStorage storage = FirebaseStorage.instance;
  DashboardViewModel homeViewModel = Get.find();
  DashboardViewModel dashboardViewModel = Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllTrainingData();
  }

  Future<void> getAllTrainingData() async {
    await Future.delayed(const Duration(seconds: 3));
    CollectionReference reference = firestore
        .collection('/all-training-data/${dashboardViewModel.mac}/user-faq');
    reference.get().then((value) {
      dataList.value = value.docs;
    });
  }

  Future<void> insertTrainingData(Map<String, dynamic> data) async {
    CollectionReference reference = firestore
        .collection('/all-training-data/${dashboardViewModel.mac}/user-faq');
    await reference.add(data).then((documentReference) {
      print('DocumentSnapshot added with ID: ${documentReference.id}');
    }).catchError((e) {
      print('Error adding document: $e');
    });
  }

  void updateTrainingData(
      String docId, String question, String answer, String status) async {
    CollectionReference reference = firestore
        .collection('/all-training-data/${dashboardViewModel.mac}/user-faq');
    await reference.doc(docId).update({
      'question': question,
      'answer': answer,
      'status': status,
    }).then((_) {
      print("Document successfully updated");
    }).catchError((error) {
      print("Error updating document: $error");
    });
  }

  void deleteTrainingData(String docId) async {
    CollectionReference reference = firestore
        .collection('/all-training-data/${dashboardViewModel.mac}/user-faq');
    await reference.doc(docId).delete().then((_) {
      print("Document successfully deleted");
    }).catchError((error) {
      print("Error deleting document: $error");
    });
  }
}
