import 'package:flutter/material.dart';
import 'package:franc_third_party_integration_demo/web_view_app_screen.dart';
import 'package:franc_third_party_integration_demo/services/api_service.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Franc Third Party Reference Integration Demo"),
            centerTitle: true,
            automaticallyImplyLeading: false),
        body: WillPopScope(
          onWillPop: () async => true,
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Click one of the below!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.orange,
                      backgroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      var url = await ApiService.getBreakoutURL();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewApp(
                                url)),
                      );
                    },
                    child: const Text('REGISTER'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.orange,
                      backgroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewApp(
                                "https://test.partners-ui.franc.app/deposit")),
                      );
                    },
                    child: const Text('DEPOSIT'),
                  ),
                ]),
          ),
        ));
  }
}
