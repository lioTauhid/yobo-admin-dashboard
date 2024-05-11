import 'package:YOBO_Bot/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../res/components/custom_dialog.dart';
import '../../res/constants/app_color.dart';
import '../../res/constants/value.dart';
import '../../view_model/training/training_view_model.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  TrainingViewModel trainingViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
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
            Icon(Icons.model_training, color: secondaryColor),
            SizedBox(width: 8),
            Text(
              "Model Training",
              style: TextStyle(
                  color: secondaryColor,
                  fontSize: fontSmall,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                trainingViewModel.getAllTrainingData();
              },
              icon: const Icon(FontAwesomeIcons.rotate,
                  color: secondaryColor, size: 20)),
          IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.chartPie,
                  color: secondaryColor, size: 20)),
          IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.chartBar,
                  color: secondaryColor, size: 20)),
          const SizedBox(width: 20)
        ],
      ),
      floatingActionButton: SizedBox(
        height: 55,
        width: 160,
        child: MaterialButton(
          onPressed: () {
            editUpdateFaq(context, '', '', isEdit: false);
          },
          color: primaryColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          padding: const EdgeInsets.all(5),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.plus, color: secondaryColor),
              SizedBox(width: 5),
              Text(
                "Add Question",
                style: TextStyle(color: secondaryColor),
              )
            ],
          ),
        ),
      ),
      body: Container(
        height: Size.infinite.height,
        width: Size.infinite.width,
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          return ListView.builder(
              itemCount: trainingViewModel.dataList.length,
              padding: const EdgeInsets.only(bottom: 60),
              itemBuilder: (ctx, i) {
                return Column(
                  children: [
                    ListTile(
                      leading: trainingViewModel.dataList[i]['status'] == "done"
                          ? const Icon(
                              FontAwesomeIcons.circleCheck,
                              color: primaryColor,
                              size: 30,
                            )
                          : const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                      title: Text(
                          "${trainingViewModel.dataList[i]['question']}  ${trainingViewModel.dataList[i]['status'] == "done" ? "(Trained)" : "(Pending)"}"),
                      subtitle: Text(trainingViewModel.dataList[i]['answer']),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          side: BorderSide(width: 1, color: primaryColor)),
                      trailing: SizedBox(
                        width: 145,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  runFaqLive(
                                      context,
                                      trainingViewModel.dataList[i]['question'],
                                      trainingViewModel.dataList[i]['answer']);
                                },
                                icon: const Icon(FontAwesomeIcons.play,
                                    color: primaryColor)),
                            IconButton(
                                onPressed: () {
                                  editUpdateFaq(
                                      context,
                                      trainingViewModel.dataList[i]['question'],
                                      trainingViewModel.dataList[i]['answer'],
                                      id: trainingViewModel.dataList[i].id);
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.penToSquare,
                                  color: primaryColor,
                                )),
                            IconButton(
                                onPressed: () {
                                  trainingViewModel.deleteTrainingData(
                                      trainingViewModel.dataList[i].id);
                                  trainingViewModel.getAllTrainingData();
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.trashCan,
                                  color: red,
                                )),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(height: 10)
                  ],
                );
              });
        }),
      ),
    );
  }

  Future<void> runFaqLive(BuildContext context, String qq, String ans) async {
    Utils.showLoading();
    final qController = TextEditingController(text: qq);
    final ansController = TextEditingController(text: ans);
    Size size = MediaQuery.of(context).size;
    if (kIsWeb) {
      size = size / 3;
    }
    await Future.delayed(const Duration(seconds: 3));
    Utils.hidePopup();

    showCustomDialog(
        context,
        "Live testing result",
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Question",
                    hintStyle: TextStyle(color: textPrimary),
                    labelStyle: TextStyle(color: textPrimary),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor))),
                controller: qController,
                maxLines: 6,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Answer",
                    hintStyle: TextStyle(color: textPrimary),
                    labelStyle: TextStyle(color: textPrimary),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor))),
                controller: ansController,
                maxLines: 10,
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

                  Navigator.of(context).pop();
                },
                color: accentColor,
                textColor: Colors.white,
                child: const Text("Hide"),
              ),
            ],
          ),
        ),
        MediaQuery.of(context).size.height / 4,
        kIsWeb ? size.width * 1.6 : 0);
  }

  Future<void> editUpdateFaq(BuildContext context, String qq, String ans,
      {bool isEdit = true, String id = ""}) async {
    final qController = TextEditingController(text: qq);
    final ansController = TextEditingController(text: ans);
    Size size = MediaQuery.of(context).size;
    if (kIsWeb) {
      size = size / 3;
    }

    showCustomDialog(
        context,
        isEdit ? "Edit FAQ!" : "Add FAQ",
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'ex: How can i shop?',
                    labelText: "Enter Question",
                    hintStyle: TextStyle(color: textPrimary),
                    labelStyle: TextStyle(color: textPrimary),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor))),
                controller: qController,
                maxLines: 6,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'ex: Simply visit our website...',
                    labelText: "Enter Answer",
                    hintStyle: TextStyle(color: textPrimary),
                    labelStyle: TextStyle(color: textPrimary),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor))),
                controller: ansController,
                maxLines: 10,
              ),
              MaterialButton(
                elevation: 0,
                minWidth: MediaQuery.of(context).size.width / 4,
                height: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  // setState(() => mac = macController.text);
                  if (isEdit) {
                    // edit
                    trainingViewModel.updateTrainingData(
                        id, qController.text, ansController.text, 'review');
                  } else {
                    // insert
                    trainingViewModel.insertTrainingData({
                      'question': qController.text,
                      'answer': ansController.text,
                      'status': 'review',
                    });
                  }
                  trainingViewModel.getAllTrainingData();
                  Navigator.of(context).pop();
                },
                color: accentColor,
                textColor: Colors.white,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
        MediaQuery.of(context).size.height / 4,
        kIsWeb ? size.width * 1.6 : 0);
  }
}
