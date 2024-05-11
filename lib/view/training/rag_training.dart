
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../res/constants/app_color.dart';

class RagTraining extends StatefulWidget {
  const RagTraining({super.key});

  @override
  State<RagTraining> createState() => _RagTrainingState();
}

class _RagTrainingState extends State<RagTraining> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (kIsWeb) {
      size = size / 3;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Training with Rag'),
        backgroundColor: primaryColor,
        toolbarHeight: 40,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.rotateRight,
                  color: secondaryColor, size: 20)),
          const SizedBox(width: 20)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor.withOpacity(0.3),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Running File : ",
                  style: TextStyle(
                      color: textSecondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 130,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(6),
                  leading: const Icon(
                    FontAwesomeIcons.filePdf,
                    color: primaryColor,
                    size: 30,
                  ),
                  title: const Text("file_54565454564685.pdf"),
                  subtitle: const Text("16 Jan 2024 \nStatus: running"),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      side: BorderSide(width: 1, color: primaryColor)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MaterialButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              // print(result.files.single.name);
                              // File file = File(result.files.single.path!);
                            } else {
                              // User canceled the picker
                            }
                          },
                          height: 60,
                          minWidth: 130,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          color: accentColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              side: BorderSide(width: 1, color: primaryColor)),
                          child: const Row(
                            children: [
                              Text("Upload",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(
                                FontAwesomeIcons.fileArrowUp,
                                color: white,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor.withOpacity(0.3),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Older Files : ",
                  style: TextStyle(
                      color: textSecondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              for (int i = 0; i < 10; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(6),
                    leading: const Icon(
                      FontAwesomeIcons.clockRotateLeft,
                      color: secondaryColor,
                      size: 26,
                    ),
                    title: const Text("file_54565454564685.pdf"),
                    subtitle: const Text("16 Jan 2024 \nStatus: replaced"),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        side: BorderSide(width: 1, color: primaryColor)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MaterialButton(
                            onPressed: () {},
                            height: 60,
                            minWidth: 130,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            color: accentColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                side:
                                    BorderSide(width: 1, color: primaryColor)),
                            child: const Row(
                              children: [
                                Text("View",
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 8),
                                Icon(
                                  FontAwesomeIcons.eye,
                                  color: white,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
