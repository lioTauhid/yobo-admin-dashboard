import 'package:flutter/material.dart';
import '../constants/app_color.dart';

class InterNetExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;

  const InterNetExceptionWidget({super.key, required this.onPress});

  @override
  State<InterNetExceptionWidget> createState() =>
      _InterNetExceptionWidgetState();
}

class _InterNetExceptionWidgetState extends State<InterNetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * .15,
          ),
          const Icon(
            Icons.cloud_off,
            color: red,
            size: 50,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
                child: Text(
              'Internet Exception',
              textAlign: TextAlign.center,
            )),
          ),
          const SizedBox(
            height: 20
          ),
          InkWell(
            onTap: widget.onPress,
            child: Container(
              height: 44,
              width: 160,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                  child: Text(
                'Retry',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
