import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff209fa6);
// const Color secondaryColor = Color(0xff168d91);
// const Color accentColor = Colors.blueAccent;

// const Color primaryColor = Color(0xff03A9F4);
const Color secondaryColor = Color(0xffB3E5FC);
const Color accentColor = Color(0xff00BCD4);
const Color alternate = Color.fromRGBO(76, 66, 67, 0.66);

Color textPrimary = const Color(0xff212121);
Color textSecondary = const Color(0xff757575);
Color primaryBackground = const Color(0xffFFFFFF);
Color secondaryBackground = const Color(0xff2E2E2E);

const Color red = Colors.red;
const Color white = Colors.white;
const Color black = Colors.black;
const Color black12 = Colors.black12;

const Color kBgColor = Color(0xFFecf5fb);
const Color kDarkGreyColor = Color(0xFF727C9B);
const Color kGreenColor = Color(0xFF47f03e);

void applyThem(bool dark) {
  if (dark) {
    textPrimary = const Color(0xffFFFFFF);
    textSecondary = const Color(0xffD9D9D9);
    primaryBackground = const Color(0xff121212);
    secondaryBackground = const Color(0xff262626);
    // alternate = const Color(0xff434343);
  } else {
    textPrimary = const Color(0xff262626);
    textSecondary = const Color(0xff7B7B7B);
    primaryBackground = const Color(0xffF1F4F8);
    secondaryBackground = const Color(0xffFFFFFF);
    // alternate = const Color(0xffF5F5F5);
  }
}
