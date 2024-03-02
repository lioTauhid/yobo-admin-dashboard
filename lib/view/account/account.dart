import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/constants/app_color.dart';
import '../../../res/constants/value.dart';
import '../../res/routes/routes_name.dart';
import '../../view_model/dashboad/dashboard_view_model.dart';
import '../dashboard/dashboard.dart';

class Account extends StatelessWidget {
  Account({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;
  DashboardViewModel dashboardViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBackground,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/bg.png",
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Edit Profile Photo',
                      style: TextStyle(
                          fontSize: fontMediumExtra, color: secondaryColor),
                    )),
              ),
              const SizedBox(height: 10),
              Text(
                "Mode",
                style: TextStyle(color: textSecondary, fontSize: fontMedium),
              ),
              ListTile(
                title: Text('Enable Dark Mode',
                    style: TextStyle(color: textPrimary)),
                trailing: Switch(
                  // thumb color (round icon)
                  activeColor: primaryColor,
                  activeTrackColor: accentColor,
                  inactiveThumbColor: textPrimary,
                  inactiveTrackColor: textSecondary,
                  splashRadius: 50.0,
                  // boolean variable value
                  value: darkMode,
                  // changes the state of the switch
                  onChanged: (value) {
                    if (darkMode) {
                      darkMode = false;
                      applyThem(darkMode);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const DashBoard()));
                    } else {
                      darkMode = true;
                      applyThem(darkMode);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const DashBoard()));
                    }
                  },
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              Divider(color: textPrimary, thickness: 0.4),
              const SizedBox(height: 10),
              Text(
                "Accessibility",
                style: TextStyle(color: textSecondary, fontSize: fontMedium),
              ),
              ListTile(
                title: Text('Edit Visual Mode (color, contrast, font ...)',
                    style: TextStyle(color: textPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, color: textPrimary),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              Divider(color: textPrimary, thickness: 0.4),
              const SizedBox(height: 10),
              Text(
                "Account Details",
                style: TextStyle(color: textSecondary, fontSize: fontMedium),
              ),
              ListTile(
                title: Text('Edit Profile Details',
                    style: TextStyle(color: textPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, color: textPrimary),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              ListTile(
                title: Text('Edit Bootcamp Details',
                    style: TextStyle(color: textPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, color: textPrimary),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              ListTile(
                title: Text('Manage Connections',
                    style: TextStyle(color: textPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, color: textPrimary),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              ListTile(
                title: Text('Update Attendance',
                    style: TextStyle(color: textPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, color: textPrimary),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              Divider(color: textPrimary, thickness: 0.4),
              const SizedBox(height: 10),
              Text(
                "Account Settings",
                style: TextStyle(color: textSecondary, fontSize: fontMedium),
              ),
              ListTile(
                title:
                    Text('Career Goals', style: TextStyle(color: textPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, color: textPrimary),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              ListTile(
                title: Text('Account Security',
                    style: TextStyle(color: textPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, color: textPrimary),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              ListTile(
                title: Text('Notification Preferences',
                    style: TextStyle(color: textPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, color: textPrimary),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              Divider(color: textPrimary, thickness: 0.4),
              const SizedBox(height: 10),
              Text(
                "Help & Support",
                style: TextStyle(color: textSecondary, fontSize: fontMedium),
              ),
              ListTile(
                title: Text('About GetMeHired.co',
                    style: TextStyle(color: textPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, color: textPrimary),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              ListTile(
                title: Text('Frequently Asked Questions',
                    style: TextStyle(color: textPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, color: textPrimary),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              ListTile(
                title: Text('Share the GetMeHired.co app',
                    style: TextStyle(color: textPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, color: textPrimary),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              ListTile(
                title: Text('Contact Support',
                    style: TextStyle(color: textPrimary)),
                trailing: Icon(Icons.arrow_forward_ios, color: textPrimary),
                contentPadding: EdgeInsets.zero,
                onTap: () {},
              ),
              Divider(color: textPrimary, thickness: 0.4),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                    onPressed: () {
                      dashboardViewModel.logout().then(
                          (value) => Get.offNamed(RouteName.splashScreen));
                    },
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(
                          fontSize: fontMediumExtra, color: accentColor),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
