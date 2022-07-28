import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:franc_third_party_integration_demo/home_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  final String url;

  WebViewApp(this.url);

  @override
  _WebViewAppState createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  var url = "";
  final Completer<WebViewController> _webviewController =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Franc Third Party Integration Demo"),
            centerTitle: true,
            automaticallyImplyLeading: false),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webviewController) {
            _webviewController.complete(webviewController);
          },
          onPageFinished: (String url) {
            setState(
              () {
                this.url = url.toString();
              },
            );

            if (url == "https://partners-ui.franc.app/blank") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          },
        ));
  }
}
