import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/constants/app_color.dart';
import '../../res/constants/value.dart';
import '../home/qr_connect.dart';

class WebChat extends StatefulWidget {
  const WebChat({super.key});

  @override
  _WebChatState createState() => _WebChatState();
}

class _WebChatState extends State<WebChat> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewOptions options = InAppWebViewOptions(
    mediaPlaybackRequiresUserGesture: false,
  );

  PullToRefreshController? pullToRefreshController;

  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryBackground,
        appBar: AppBar(
          backgroundColor: primaryColor,
          toolbarHeight: 40,
          elevation: 0,
          title: const Row(
            children: [
              // Image.asset("assets/Group 946.png"),
              Icon(FontAwesomeIcons.weebly, color: secondaryColor),
              SizedBox(width: 8),
              Text(
                "ChatBot Web",
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
                  webViewController?.reload();
                },
                icon: const Icon(FontAwesomeIcons.rotate,
                    color: secondaryColor, size: 20)),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ConnectByQr()));                },
                icon: const Icon(Icons.qr_code_2,
                    color: secondaryColor, size: 24)),
            const SizedBox(width: 20)
          ],
        ),
        body: SafeArea(
            child: Expanded(
          child: Stack(
            children: [
              InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(
                    url: Uri.tryParse(
                        'https://yobo.megamindtech.com/chat?model=ft:gpt-3.5-turbo-0613:megamind-tech:mega-t4:8AHr6elN')),
                // initialUrlRequest:
                // URLRequest(url: WebUri(Uri.base.toString().replaceFirst("/#/", "/") + 'page.html')),
                // initialFile: "assets/index.html",
                initialUserScripts: UnmodifiableListView<UserScript>([]),
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) async {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) async {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var uri = navigationAction.request.url!;

                  if (![
                    "http",
                    "https",
                    "file",
                    "chrome",
                    "data",
                    "javascript",
                    "about"
                  ].contains(uri.scheme)) {
                    if (await canLaunchUrl(uri)) {
                      // Launch the App
                      await launchUrl(
                        uri,
                      );
                      // and cancel the request
                      return NavigationActionPolicy.CANCEL;
                    }
                  }

                  return NavigationActionPolicy.ALLOW;
                },
                onLoadStop: (controller, url) async {
                  pullToRefreshController?.endRefreshing();
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController?.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                    urlController.text = this.url;
                  });
                },
                onUpdateVisitedHistory: (controller, url, isReload) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
              ),
              progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : const SizedBox(),
            ],
          ),
        )));
  }
}
