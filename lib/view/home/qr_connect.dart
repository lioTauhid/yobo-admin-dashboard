import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../res/constants/app_color.dart';
import 'home.dart';

class ConnectByQr extends StatefulWidget {
  const ConnectByQr({Key? key}) : super(key: key);

  @override
  _ConnectByQrState createState() => _ConnectByQrState();
}

class _ConnectByQrState extends State<ConnectByQr> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final tagController = TextEditingController();
  late QRViewController qrViewController;
  late Barcode barcode;
  bool flashOn = false;

  final rootRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    // showConfigDialog(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          qrView(context),
          Positioned(
              top: 40,
              child: Container(
                height: 50,
                width: 120,
                // padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () async {
                          qrViewController.toggleFlash();
                          if (flashOn) {
                            flashOn = false;
                          } else {
                            flashOn = true;
                          }
                          setState(() {});
                        },
                        icon: flashOn
                            ? const Icon(Icons.flash_on)
                            : const Icon(Icons.flash_off)),
                    IconButton(
                        onPressed: () async {
                          qrViewController.flipCamera();
                          setState(() {});
                        },
                        icon: const Icon(Icons.flip_camera_ios)),
                  ],
                ),
              )),
          Positioned(
              top: 40,
              left: 15,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back, color: white),
                iconSize: 30,
              ))
        ],
      ),
    );
  }

  Widget qrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Theme.of(context).primaryColor,
            borderRadius: 10,
            borderLength: 20,
            borderWidth: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.8),
      );

  void onQRViewCreated(QRViewController qrViewController) {
    setState(() => this.qrViewController = qrViewController);
    qrViewController.scannedDataStream.listen((event) {
      setState(() => barcode = event);

      var id = barcode.code!.split("-");

      if (id[0] == "MegaId") {
        qrViewController.pauseCamera();
        showConfigDialog(context);
      } else {
        showSnackBar(context, "This is not a correct QR code");
      }
    });
  }

  Future<void> showConfigDialog(BuildContext context) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Configure and connect device'),
          actions: [
            MaterialButton(
              elevation: 0,
              minWidth: MediaQuery.of(context).size.width / 4,
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              onPressed: () {
                // setState(() => mac = barcode.code!.split("-")[1]);
                // rootRef
                //     .child("devices")
                //     .child(macAddress)
                //     .child("tag")
                //     .set(tagController.text);
                // rootRef
                //     .child("devices")
                //     .child(macAddress)
                //     .child("reboot")
                //     .set("on");
                // setState(() => SharedPref().saveValue("macAddress", mac));

                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const Home()));

                // Navigator.of(context).pop();
              },
              color: accentColor,
              textColor: Colors.white,
              child: const Text("Connect"),
            ),
            MaterialButton(
              elevation: 0,
              minWidth: MediaQuery.of(context).size.width / 4,
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              onPressed: () {
                qrViewController.resumeCamera();
                Navigator.of(context).pop();
              },
              color: accentColor,
              textColor: Colors.white,
              child: const Text("Cancel"),
            ),
          ],
          content: SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height - 650,
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Enter Place TAG',
                  textAlign: TextAlign.center,
                ),
                Card(
                  elevation: 2,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'ex: pizza_shop'),
                        controller: tagController,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: accentColor,
      action: SnackBarAction(
        label: 'Ok',
        textColor: secondaryColor,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    qrViewController.dispose();
    super.dispose();
  }
}
