import 'package:flutter/material.dart';
import 'package:franc_third_party_integration_demo/web_view_app_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Franc Third Patry Integration Demo"),
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
                      padding: EdgeInsets.all(16.0),
                      primary: Colors.orange,
                      backgroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewApp(
                                "https://partners-ui.franc.app/register")),
                      );
                    },
                    child: Text('REGISTER'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(16.0),
                      primary: Colors.orange,
                      backgroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewApp(
                                "https://partners-ui.franc.app/deposit")),
                      );
                    },
                    child: Text('DEPOSIT'),
                  ),
                ]),
          ),
        ));
  }
}
