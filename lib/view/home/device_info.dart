import 'package:YOBO_Bot/res/constants/app_color.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/dashboad/dashboard_view_model.dart';

class DeviceInfo extends StatefulWidget {
  DeviceInfo(this.deviceInfo, {super.key});
  Map deviceInfo;

  @override
  _DeviceInfoState createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  DashboardViewModel dashboardViewModel = Get.find();
  final rootRef = FirebaseDatabase.instance.ref();
  TextEditingController infoController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tagController.text = widget.deviceInfo["tag"];
    infoController.text = widget.deviceInfo["info"] ?? "";
    placeController.text = widget.deviceInfo["place"] ?? "";
    // print(widget.deviceInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Size.infinite.height,
        width: Size.infinite.width,
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Device Mac: ${dashboardViewModel.mac.value}\n"
              "Device Name : ${tagController.text}\n"
              "Device Ip : ${widget.deviceInfo["ip"]}",
              style: const TextStyle(fontSize: 20),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Device Name", border: OutlineInputBorder()),
              controller: tagController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Place/Location", border: OutlineInputBorder()),
              controller: placeController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Device Description",
                  hintText: "Write about device...",
                  border: OutlineInputBorder()),
              maxLines: 5,
              controller: infoController,
            ),
            MaterialButton(
              elevation: 0,
              minWidth: MediaQuery.of(context).size.width / 3,
              height: 60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              onPressed: () {
                rootRef
                    .child("devices")
                    .child(dashboardViewModel.mac.value)
                    .child("info")
                    .set(infoController.text);
                rootRef
                    .child("devices")
                    .child(dashboardViewModel.mac.value)
                    .child("tag")
                    .set(tagController.text);
                rootRef
                    .child("devices")
                    .child(dashboardViewModel.mac.value)
                    .child("place")
                    .set(placeController.text);
                rootRef
                    .child("devices/${dashboardViewModel.mac.value}/reboot")
                    .set("on");

                setState(
                    () => dashboardViewModel.tag.value = tagController.text);
                Navigator.of(context).pop();
              },
              color: primaryColor,
              textColor: Colors.white,
              child: const Text("Save Info"),
            ),
          ],
        ),
      ),
    );
  }
}
