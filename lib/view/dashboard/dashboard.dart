import 'package:YOBO_Bot/view/account/account.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/constants/value.dart';
import '../../res/constants/app_color.dart';
import '../../view_model/dashboad/dashboard_view_model.dart';
import '../../view_model/home/home_view_models.dart';
import '../../view_model/training/training_view_model.dart';
import '../analytics/analytics.dart';
import '../home/home.dart';
import '../training/training_page.dart';
import '../webchat/webchat.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  HomeViewModel homeViewModel = Get.put(HomeViewModel());
  DashboardViewModel dashboardViewModel = Get.put(DashboardViewModel());
  TrainingViewModel trainingViewModel =Get.put(TrainingViewModel());

  final List<Widget> _widgetOptions = [
    const Home(),
    Analytics(),
    const TrainingPage(),
    Account(),
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
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
        backgroundColor: primaryColor,
        body: Center(
          child: _widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 30),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics, size: 29),
              label: 'Analytics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.model_training, size: 29),
              label: 'Training',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, size: 29),
              label: 'Account',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: primaryColor,
          currentIndex: selectedIndex,
          // selectedIconTheme:
          // const IconThemeData(color: primaryColor, opacity: 1),
          // unselectedIconTheme:
          // IconThemeData(color: textSecondary, opacity: 1),
          selectedItemColor: secondaryColor,
          unselectedItemColor: secondaryBackground,
          selectedLabelStyle:
              const TextStyle(fontSize: fontSmall, color: secondaryColor),
          unselectedLabelStyle:
              TextStyle(fontSize: fontSmall, color: secondaryBackground),
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
