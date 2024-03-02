import 'package:YOBO_Bot/utils/utils.dart';
import 'package:YOBO_Bot/view/dashboard/dashboard.dart';
import 'package:YOBO_Bot/view/home/qr_connect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../res/components/common_widgets.dart';
import '../../res/components/custom_dialog.dart';
import '../../res/routes/routes_name.dart';
import '../../view_model/analytics/analytics_view_model.dart';
import '../../view_model/dashboad/dashboard_view_model.dart';
import '../../view_model/home/home_view_models.dart';
import 'device_body.dart';
import 'drawer.dart';
import '../../res/constants/value.dart';
import '../../res/constants/app_color.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  HomeViewModel homeViewModel = Get.find();
  DashboardViewModel dashboardViewModel = Get.find();

  final user = FirebaseAuth.instance.currentUser;
  final rootRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (kIsWeb) {
      size = size / 3;
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primaryBackground,
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 60,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: secondaryColor,
          ),
        ),
        title: const Row(
          children: [
            // Image.asset("assets/Group 946.png"),
            Icon(Icons.account_circle, color: secondaryColor),
            SizedBox(width: 8),
            Text(
              "Admin Dashboard",
              style: TextStyle(
                  color: secondaryColor,
                  fontSize: fontSmall,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.arrowsRotate,
                  color: secondaryColor, size: 20)),
          IconButton(
              onPressed: () {
                showDeviceDialog(context);
              },
              icon: const Icon(FontAwesomeIcons.towerCell,
                  color: secondaryColor, size: 20)),
          const SizedBox(width: 20)
        ],
      ),
      drawer: sideDrawer(context),
      drawerScrimColor: Colors.transparent,
      body: Container(
        height: Size.infinite.height,
        width: Size.infinite.width,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Obx(() {
          return setBody(context, dashboardViewModel.mac.value);
        }),
      ),
    );
  }

  Widget setBody(BuildContext context, String mac) {
    if (dashboardViewModel.mac.isNotEmpty) {
      // Has mac
      return const DeviceBody();
    } else {
      // Has no mac
      return Column(
        children: [
          SizedBox(
            height: 500,
            width: 500,
            child: Lottie.network(
                "https://lottie.host/f0f93176-f1c3-462c-a779-7e57de2aa314/8S6HhgsK0V.json",
                fit: BoxFit.fill),
          ),
          Text(
            'No device connected. \nAdd or select device first to configure, control...',
            textAlign: TextAlign.center,
            style: TextStyle(color: textSecondary, fontSize: fontSmall),
          ),
          const SizedBox(height: 30),
          SizedBox(
              height: 50,
              width: 300,
              child: iconTextBtn(
                  const Icon(Icons.qr_code_2, color: secondaryColor),
                  " Add by QR-code",
                  primaryColor,
                  white,
                  fontSmall, onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ConnectByQr()));
              })),
          const SizedBox(height: 20),
          SizedBox(
              height: 50,
              width: 300,
              child: iconTextBtn(
                  const Icon(Icons.edit, color: secondaryColor),
                  " Add by MAC address",
                  primaryColor,
                  white,
                  fontSmall, onPressed: () {
                addByMacDialog(context);
              })),
        ],
      );
    }
  }

  Future<void> addByMacDialog(BuildContext context) async {
    final macController = TextEditingController();
    final tagController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    if (kIsWeb) {
      size = size / 3;
    }

    showCustomDialog(
        context,
        "Add Device by Mac Address",
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'ex: 04:6c:59:ca:d8:6b',
                    labelText: "Enter Mac Address",
                    hintStyle: TextStyle(color: textPrimary),
                    labelStyle: TextStyle(color: textPrimary),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor))),
                controller: macController,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'ex: pizza_shop',
                    labelText: "Enter Place/Device TAG",
                    hintStyle: TextStyle(color: textPrimary),
                    labelStyle: TextStyle(color: textPrimary),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor))),
                controller: tagController,
              ),
              MaterialButton(
                elevation: 0,
                minWidth: MediaQuery.of(context).size.width / 4,
                height: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () async {
                  // setState(() => mac = macController.text);
                  await rootRef
                      .child("devices")
                      .child(macController.text)
                      .child("place")
                      .set(tagController.text);
                  await rootRef
                      .child("users")
                      .child(user!.uid)
                      .child(macController.text)
                      .set(tagController.text);
                  rootRef
                      .child("devices/${macController.text}/reboot")
                      .set("on");
                  await dashboardViewModel.saveMacAddress(macController.text);
                  Utils.hidePopup();
                  Get.offNamed(RouteName.dashBoard);
                  AnalyticsViewModel analyticsViewModel = Get.find();
                  analyticsViewModel.listAnalyticsDate();
                  Navigator.of(context).pop();
                },
                color: accentColor,
                textColor: Colors.white,
                child: const Text("Connect"),
              ),
            ],
          ),
        ),
        MediaQuery.of(context).size.height / 2,
        kIsWeb ? size.width * 1.6 : 0);
  }

  Future<void> showDeviceDialog(BuildContext context) async {
    var statusList = [];
    var deviceList = [];
    var deviceTag = [];
    late StateSetter stateSetter;
    rootRef.child("users").child(user!.uid).once().then((value) {
      deviceList.clear();
      deviceTag.clear();
      (value.snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
        deviceList.add(key);
        deviceTag.add(value);
        rootRef.child("devices").child(key).child("status").set("check");
      });
      stateSetter(() {});
    });
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            stateSetter = setState;
            return AlertDialog(
              title: const Text('Device List'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Hide"),
                ),
              ],
              content: SizedBox(
                width: kIsWeb
                    ? MediaQuery.of(context).size.width / 2.8
                    : double.maxFinite,
                height: MediaQuery.of(context).size.height - 400,
                child: ListView.builder(
                  itemCount: deviceList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return deviceTag.isEmpty
                        ? const Row()
                        : Card(
                            elevation: 3,
                            child: ListTile(
                                title: Text(deviceTag[index]),
                                subtitle: Text(deviceList[index]),
                                trailing: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: statusList.isEmpty
                                          ? Colors.redAccent
                                          : statusList[index] == "online"
                                              ? Colors.greenAccent[400]
                                              : Colors.redAccent),
                                ),
                                onTap: () async {
                                  // localData.write("macAddress",
                                  //     deviceList[index].toString());
                                  // setState(
                                  //     () => mac = localData.read("macAddress"));
                                  await dashboardViewModel.saveMacAddress(
                                      deviceList[index].toString());
                                  // print(deviceList[index].toString());
                                  // setState(() {
                                  //   mac = deviceList[index].toString();
                                  // });

                                  Utils.hidePopup();
                                  // Get.offNamed(RouteName.dashBoard);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const DashBoard()));
                                  AnalyticsViewModel analyticsViewModel =
                                      Get.find();
                                  analyticsViewModel.listAnalyticsDate();
                                }),
                          );
                  },
                ),
              ),
            );
          },
        );
      },
    );
    await Future.delayed(const Duration(seconds: 4));
    statusList.clear();
    for (var d in deviceList) {
      await rootRef
          .child("devices")
          .child(d)
          .child("status")
          .once()
          .then((value) {
        statusList.add(value.snapshot.value);
      });
      if (statusList.length == deviceList.length) {
        stateSetter(() {});
      }
    }
  }
}
