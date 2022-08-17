// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_ui/universal_ui.dart';
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

  @override
  void initState() {
    // ignore: undefined_prefixed_name
    if (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS){
      ui.platformViewRegistry.registerViewFactory(
          'hello-world-html',
          (int viewId) => html.IFrameElement()
            ..width = '640'
            ..height = '360'
            ..src = widget.url
            ..style.border = 'none'
            ..onLoad.listen((event) {
              html.window.onMessage.forEach((element) {
                if(element.data=='CLOSED'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                }
              });
            }));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    url = widget.url;
    return Scaffold(
        appBar: AppBar(
            title: const Text("Franc Third Party Integration Demo"),
            centerTitle: true,
            automaticallyImplyLeading: false),
        body: (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS) ?
            HtmlElementView(viewType: 'hello-world-html')
          : WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webviewController) {
                final Completer<WebViewController> _webviewController =
                    Completer<WebViewController>();
                _webviewController.complete(webviewController);
              },
              onPageFinished: (String url) {
                setState(
                  () {
                    this.url = url.toString();
                  },
                );
                if (url.contains("blank")) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                }
              },
            )
    );
  }
}
