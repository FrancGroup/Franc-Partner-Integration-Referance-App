import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'home_screen.dart';

class WebViewApp extends StatefulWidget {
  final String url;

  WebViewApp(this.url);

  @override
  _WebViewAppState createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  @override
  void initState() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        'hello-world-html',
        (int viewId) => html.IFrameElement()
          ..width = '640'
          ..height = '360'
          ..src = widget.url
          ..style.border = 'none'
          ..onLoad.listen((event) {
            html.window.onMessage.forEach((element) {
              print('Event Received in callback: ${element.data}');
              if(element.data=='CLOSED'){
                print('wooot');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }else if(element.data=='SUCCESS'){
                print('PAYMENT SUCCESSFULL!!!!!!!');
              }
            });
          }));
    super.initState();
  }

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
        body: const HtmlElementView(viewType: 'hello-world-html'));
  }
}
