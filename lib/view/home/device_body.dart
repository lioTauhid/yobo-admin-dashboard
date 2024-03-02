import 'package:YOBO_Bot/res/constants/app_color.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../res/components/custom_dialog.dart';
import '../../res/constants/value.dart';
import '../../res/routes/routes_name.dart';
import '../../view_model/dashboad/dashboard_view_model.dart';
import '../../view_model/home/home_view_models.dart';
import 'device_info.dart';

class DeviceBody extends StatefulWidget {
  const DeviceBody({super.key});

  @override
  State<DeviceBody> createState() => _DeviceBodyState();
}

class _DeviceBodyState extends State<DeviceBody> {
  DashboardViewModel dashboardViewModel = Get.find();
  HomeViewModel homeViewModel = Get.find();
  Map deviceInfo = {};
  Map botConfig = {};
  final rootRef = FirebaseDatabase.instance.ref();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDeviceInfo();
    print(("called............"));
  }

  void loadDeviceInfo() async {
    // load device
    isLoading = true;
    deviceInfo.clear();
    botConfig.clear();
    await rootRef
        .child("devices")
        .child(dashboardViewModel.mac.value)
        .once()
        .then((value) {
      deviceInfo = value.snapshot.value as Map;
      botConfig = deviceInfo["botConfig"] as Map;
      print(deviceInfo);
      print(botConfig);
    });
    setState(() {});
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (kIsWeb) {
      size = size / 3;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Container(
                      height: 140,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kBgColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: black12,
                            blurRadius: 8,
                            offset: Offset(3, 3),
                          ),
                          BoxShadow(
                            color: white,
                            blurRadius: 0,
                            offset: Offset(-3, -3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                deviceInfo["tag"],
                                style: const TextStyle(
                                    fontSize: fontMedium,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.circle,
                                  color: deviceInfo["status"] == 'online'
                                      ? kGreenColor
                                      : red,
                                  size: 35),
                            ],
                          ),
                          Text(
                            "Ip: " + deviceInfo["ip"].split(" ")[0],
                            style: TextStyle(
                              fontSize: fontSmall,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                          Text(
                            deviceInfo["status"] == 'online'
                                ? "Online"
                                : "Offline",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSmall,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                              height: 120,
                              child: actionButton(
                                  "Restart",
                                  "",
                                  FontAwesomeIcons.rotateRight,
                                  false,
                                  const CircularProgressIndicator(), onTap: () {
                                homeViewModel
                                    .rebootDevice(dashboardViewModel.mac.value);
                              })),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: SizedBox(
                              height: 120,
                              child: actionButton(
                                  "Edit Info",
                                  "",
                                  FontAwesomeIcons.circleQuestion,
                                  false,
                                  const CircularProgressIndicator(), onTap: () {
                                showCustomDialog(
                                    context,
                                    "Device Information's",
                                    DeviceInfo(deviceInfo),
                                    0,
                                    kIsWeb ? size.width * 1.5 : 0);
                              })),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                        height: 160,
                        width: MediaQuery.of(context).size.width,
                        child: actionButton(
                            "ChatGPT config",
                            "Model: ${botConfig["model"]}\nApi key: ${botConfig["apiKey"]}",
                            FontAwesomeIcons.squareCheck,
                            true,
                            const Icon(FontAwesomeIcons.penToSquare),
                            onTap: () {
                          Get.toNamed(RouteName.updateConfig);
                        })),
                    const SizedBox(height: 15),
                    SizedBox(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: actionButton(
                            "Firmware Update",
                            "Version: 14",
                            FontAwesomeIcons.circleDown,
                            true,
                            const CircularProgressIndicator(),
                            onTap: () {})),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Other Bot Skills",
                            style: TextStyle(
                                color: textPrimary, fontSize: fontSmall)),
                        MaterialButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text("Show more",
                                  style: TextStyle(
                                      color: textPrimary, fontSize: fontSmall)),
                              const Icon(FontAwesomeIcons.angleRight)
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                              height: 120,
                              width: 180,
                              child: switchButton(
                                  "Faq Bot", FontAwesomeIcons.comments, true)),
                          const SizedBox(width: 15),
                          SizedBox(
                              height: 120,
                              width: 180,
                              child: switchButton("Image Chat \n20\$/month)",
                                  FontAwesomeIcons.images, false)),
                          const SizedBox(width: 15),
                          SizedBox(
                              height: 120,
                              width: 180,
                              child: switchButton("Interaction",
                                  FontAwesomeIcons.thumbsUp, true)),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget switchButton(String text, IconData icon, bool isChecked,
      {Function(bool)? onSwitch}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: kBgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: black12,
            blurRadius: 8,
            offset: Offset(3, 3),
          ),
          BoxShadow(
            color: white,
            blurRadius: 0,
            offset: Offset(-3, -3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon),
              CupertinoSwitch(
                activeColor: primaryColor,
                value: isChecked,
                onChanged: onSwitch,
              ),
            ],
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: fontSmall,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          Text(
            isChecked ? "On" : "Off",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSmall,
              color: isChecked ? kGreenColor : textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget actionButton(String text, String status, IconData icon, bool isClicked,
      Widget trailing,
      {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kBgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: black12,
              blurRadius: 8,
              offset: Offset(3, 3),
            ),
            BoxShadow(
              color: white,
              blurRadius: 0,
              offset: Offset(-3, -3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(icon), isClicked ? trailing : const SizedBox()],
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: fontSmall,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            Text(
              status,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSmall,
                color: textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
