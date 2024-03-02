import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../constants/value.dart';

Widget sideBarIconBtn(String imagePath, Color color, {Function()? onPressed}) {
  return IconButton(
    icon: Image.asset(
      imagePath,
      color: color,
    ),
    onPressed: onPressed,
  );
}

Widget bottomIconTextBtn(String imagePath, String text, Color background,
    {Function()? onPressed}) {
  return Expanded(
    child: MaterialButton(
      elevation: 0,
      onPressed: onPressed,
      color: background,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            color: white,
            height: 15,
            width: 15,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(color: white),
          )
        ],
      ),
    ),
  );
}

Widget topBarIconBtn(
    Image image, Color background, double padding, double radius, double size,
    {Function()? onPressed}) {
  return SizedBox(
    height: size,
    width: size,
    child: MaterialButton(
        elevation: 0,
        color: background,
        padding: EdgeInsets.all(padding),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: image),
  );
}

Widget iconTextBtn(
    dynamic image, String text, Color bg, Color txtColor, double font,
    {Function()? onPressed}) {
  return MaterialButton(
    elevation: 0,
    color: bg,
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image,
        const SizedBox(width: 5),
        Text(text, style: TextStyle(color: txtColor, fontSize: font)),
      ],
    ),
  );
}

Widget iconTextBtnWide(
    String imagePath, String text, Color backColor, Color contentColor,
    {Function()? onPressed}) {
  return Container(
    width: 110,
    height: 60,
    decoration: BoxDecoration(
        color: backColor, borderRadius: BorderRadius.circular(10)),
    child: MaterialButton(
      elevation: 0,
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            color: contentColor,
          ),
          Text(text,
              style: TextStyle(color: contentColor, fontSize: fontVerySmall)),
        ],
      ),
    ),
  );
}

Widget normalButton(String text, Color background, Color textColor,
    {Function()? onPressed}) {
  return MaterialButton(
      elevation: 0,
      color: background,
      height: 45,
      minWidth: 150,
      padding: const EdgeInsets.all(10),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(400.0),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: fontVerySmall),
      ));
}

Widget normalTextField(TextEditingController controller, String hint,
    {prefIcon}) {
  return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: fontSmall, color: textPrimary),
      decoration: InputDecoration(
        fillColor: secondaryBackground,
        prefixIcon: prefIcon,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ));
}

Widget myDivider() => Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[400],
      ),
    );

Widget backButton(context) => Row(children: [
      IconButton(
        icon: const Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const Text(
        "Back",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
