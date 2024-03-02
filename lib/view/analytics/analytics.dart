import 'package:YOBO_Bot/res/components/custom_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../res/constants/app_color.dart';
import '../../res/constants/value.dart';
import '../../view_model/analytics/analytics_view_model.dart';
import 'log_view.dart';

class Analytics extends StatelessWidget {
  Analytics({super.key});

  final AnalyticsViewModel analyticsViewModel = Get.put(AnalyticsViewModel());

  @override
  Widget build(BuildContext context) {
    analyticsViewModel.listAnalyticsDate();

    Size size = MediaQuery.of(context).size;
    if (kIsWeb) {
      size = size / 3;
    }

    return Scaffold(
      backgroundColor: primaryBackground,
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 40,
        elevation: 0,
        title: const Row(
          children: [
            // Image.asset("assets/Group 946.png"),
            Icon(FontAwesomeIcons.magnifyingGlassChart, color: secondaryColor),
            SizedBox(width: 8),
            Text(
              "Analytics and Logs",
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
              icon: const Icon(FontAwesomeIcons.chartPie,
                  color: secondaryColor, size: 20)),
          IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.chartBar,
                  color: secondaryColor, size: 20)),
          IconButton(
              onPressed: () {
                analyticsViewModel.listAnalyticsDate();
              },
              icon: const Icon(FontAwesomeIcons.chartLine,
                  color: secondaryColor, size: 20)),
          const SizedBox(width: 20)
        ],
      ),
      body: Container(
        height: Size.infinite.height,
        width: Size.infinite.width,
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          return ListView.builder(
              itemCount: analyticsViewModel.dateList.length,
              itemBuilder: (ctx, i) {
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.businessTime),
                      title: Text(DateFormat.yMMMEd().format(
                          DateFormat('yyyy-MM-dd').parse(analyticsViewModel
                              .dateList[i]
                              .split('/')
                              .last
                              .split('.')
                              .first))),
                      subtitle: const Text("Device: \nUptime: 12 hour"),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          side: BorderSide(width: 1, color: primaryColor)),
                      onTap: () {
                        analyticsViewModel
                            .downloadJson(analyticsViewModel.dateList[i])
                            .then((value) {
                          showCustomDialog(
                              context,
                              "History (${DateFormat.yMMMEd().format(DateFormat('yyyy-MM-dd').parse(analyticsViewModel.dateList[i].split('/').last.split('.').first))})",
                              LogView(value),
                              0,
                              kIsWeb ? size.width * 1.5 : 0);
                        });
                      },
                    ),
                    const SizedBox(height: 10)
                  ],
                );
              });
        }),
      ),
    );
  }
}
