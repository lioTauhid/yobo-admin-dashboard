import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/components/custom_dialog.dart';
import '../../res/constants/app_color.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_model/analytics/analytics_view_model.dart';
import '../../view_model/dashboad/dashboard_view_model.dart';

Widget sideDrawer(BuildContext context) {
  DashboardViewModel dashboardViewModel = Get.find();

  final user = FirebaseAuth.instance.currentUser;
  final rootRef = FirebaseDatabase.instance.ref();

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

  return Container(
    width: 250,
    color: secondaryColor,
    alignment: Alignment.topLeft,
    margin: EdgeInsets.only(
        top: AppBar().preferredSize.height * 1.1,
        bottom: MediaQuery.of(context).size.height / 3),
    child: ListView(
      children: [
        MaterialButton(
          onPressed: () {
            Get.toNamed(RouteName.webChat);
          },
          child: const ListTile(
            title: Text('Web Chat'),
            leading: Icon(Icons.chat),
          ),
        ),
        MaterialButton(
          onPressed: () {
            addByMacDialog(context);
          },
          child: const ListTile(
            title: Text('Add Device'),
            leading: Icon(Icons.add_box),
          ),
        ),
        MaterialButton(
          onPressed: () {
            // localData.write("macAddress", null);
            // setState(() => mac = localData.read("macAddress"));
            // Navigator.of(context).pop();
          },
          child: const ListTile(
            title: Text('Clear Device'),
            leading: Icon(Icons.cleaning_services),
          ),
        ),
        MaterialButton(
          onPressed: () {
            // rootRef.child("devices").child(mac).remove();
            // rootRef.child("users").child(user.uid).child(mac).remove();
            // localData.write("macAddress", null);
            //
            // setState(() => mac = localData.read("macAddress"));
            // Navigator.of(context).pop();
          },
          child: const ListTile(
            title: Text(
              'Delete Device',
              style: TextStyle(color: Colors.redAccent),
            ),
            leading: Icon(
              Icons.delete_forever_rounded,
              color: Colors.redAccent,
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {},
          child: const ListTile(
            title: Text('About Us'),
            leading: Icon(Icons.info_outline_rounded),
          ),
        ),
        MaterialButton(
          onPressed: () {},
          child: const ListTile(
            title: Text('Support'),
            leading: Icon(Icons.contact_support_outlined),
          ),
        ),
        MaterialButton(
          onPressed: () {
            dashboardViewModel
                .logout()
                .then((value) => Get.offNamed(RouteName.splashScreen));
          },
          child: const ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
          ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const ListTile(
            title: Text('Close'),
            leading: Icon(Icons.close),
          ),
        ),
      ],
    ),
  );
}
