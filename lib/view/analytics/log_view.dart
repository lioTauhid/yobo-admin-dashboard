import 'package:YOBO_Bot/model/message.dart';
import 'package:YOBO_Bot/res/constants/app_color.dart';
import 'package:YOBO_Bot/res/constants/value.dart';
import 'package:flutter/material.dart';

class LogView extends StatelessWidget {
  const LogView(this.list, {super.key});

  final List<Message> list;

  static const double radius = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Size.infinite.height,
      width: Size.infinite.width,
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: list.length,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, index) {
          return Container(
            padding:
                const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
            child: Column(
              children: [
                Align(
                  alignment: (Alignment.topLeft),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(radius),
                          topLeft: Radius.circular(radius),
                          bottomRight: Radius.circular(radius)),
                      color: (secondaryColor),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      list[index].question.toString(),
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: fontSmall, color: textPrimary),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: (Alignment.topRight),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(radius),
                          topLeft: Radius.circular(radius),
                          bottomLeft: Radius.circular(radius)),
                      color: (primaryColor),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      list[index].answer.toString(),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: fontSmall, color: white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
