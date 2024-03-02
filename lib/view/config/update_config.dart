import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/constants/app_color.dart';
import '../../view_model/dashboad/dashboard_view_model.dart';

class UpdateConfig extends StatefulWidget {
  const UpdateConfig({key}) : super(key: key);

  @override
  _UpdateConfigState createState() => _UpdateConfigState();
}

class _UpdateConfigState extends State<UpdateConfig> {
  final rootRef = FirebaseDatabase.instance.ref();
  DashboardViewModel dashboardViewModel = Get.find();

  var botConfig = {};

  @override
  void initState() {
    super.initState();

    getAllConfig();
  }

  void getAllConfig() async {
    await rootRef
        .child("devices")
        .child(dashboardViewModel.mac.value)
        .child("botConfig")
        .once()
        .then((value) {
      setState(() => botConfig = value.snapshot.value as Map);
      print(botConfig);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (kIsWeb) {
      size = size / 3;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: kIsWeb ? size.width / 1.3 : 0),
      decoration:
      BoxDecoration(border: Border.all(width: 3, color: primaryColor)),
      child: Scaffold(
        backgroundColor: primaryBackground,
        appBar: AppBar(
          title: const Text(
            "Update All Config",
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: primaryColor,
          leading: const BackButton(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text("BioBot Config",
                  style:
                      TextStyle(color: accentColor, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Flexible(
                child: ListView.builder(
                  itemCount: botConfig.length,
                  itemBuilder: (context, index) {
                    return formItem(botConfig.keys.elementAt(index).toString(),
                        botConfig.values.elementAt(index).toString(), 1, secondaryColor);
                  },
                ),
              ),
              SizedBox(height: 15),
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
                      .child("botConfig")
                      .update(botN);
                  rootRef
                      .child("devices")
                      .child(dashboardViewModel.mac.value)
                      .child("reboot")
                      .set("on");
                  Navigator.of(context).pop();
                },
                color: accentColor,
                textColor: Colors.white,
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formItem(String key, String value, int number, Color color) {
    TextEditingController controller = TextEditingController(text: value);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 5),
      child: TextField(
        decoration: InputDecoration(
          fillColor: secondaryBackground,
          labelText: key,
          hintText: "hint",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // decoration: InputDecoration(labelText: key),
        // style: TextStyle(color: Colors.white60),
        controller: controller,
        onChanged: (val) {
          onUpdate(val, key, number);
        },
      ),
    );
  }

  Map<String, dynamic> botN = {};

  void onUpdate(String val, String key, int number) {
    String foundKey = "lio";
    if (number == 1) {
      if (botConfig.containsKey(key)) {
        foundKey = key;
        if (foundKey != "lio") {
          // botConfig.update(key.toString(), (value) => val);
          botN[key] = val;
        }
      }
    }

    print(botConfig);
  }
}
