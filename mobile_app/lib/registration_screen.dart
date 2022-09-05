import 'package:flutter/material.dart';
import 'package:franc_third_party_integration_demo/login_screen.dart';
import 'package:franc_third_party_integration_demo/services/api_service.dart';
import 'package:franc_third_party_integration_demo/web_view_app_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Franc Third Party Integration',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () {
                      ((usernameController.text != '') &&
                              (passwordController.text != ''))
                          ? handleRegister()
                          : null;
                    },
                  )),
              SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }

  void handleRegister() async {
    var response = await ApiService.register(
        usernameController.value.text,
        passwordController.value.text);
    if (response != "") {
      var url = await ApiService.getBreakoutURL(response);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewApp(url)),
      );
    }
  }
}
