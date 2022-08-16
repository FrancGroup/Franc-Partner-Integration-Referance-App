import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:franc_third_party_integration_demo/home_screen.dart';
import 'package:webviewx/webviewx.dart';

class WebViewApp extends StatefulWidget {
  final String url;

  WebViewApp(this.url);

  @override
  _WebViewAppState createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  var url = "";
  final Completer<WebViewXController> _webviewController =
      Completer<WebViewXController>();
  late WebViewXController webviewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Franc Third Party Integration Demo"),
            centerTitle: true,
            automaticallyImplyLeading: false),
        body: WebViewX(
          initialContent: widget.url,
          initialSourceType: SourceType.url,
          onWebViewCreated: (controller) => webviewController = controller,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          navigationDelegate: (NavigationRequest request){
            Uri uri = Uri.parse(request.content.source.toString());
            if (uri.toString() == "https://partners-ui.franc.app/blank"){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
            //Uri uri = Uri.parse(request.content);
          }
        ),
    );
  }
}
