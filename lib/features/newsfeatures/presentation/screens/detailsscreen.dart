import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailsSC extends StatelessWidget {
  String url;
  DetailsSC({super.key, required this.url});
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: url,
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
        )),
      ),
    );
  }
}
