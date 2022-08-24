import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static final apiHeaders = <String, String>{
    'Content-Type': 'application/json; charset=utf-8',
  };

  static const url = "https://reference-partner.franc.app";

  static Future<String> login(String username, String password) async {
    var client = http.Client();
    var body = jsonEncode(
        <String, dynamic>{'username': username, 'password': password});
    var response = await client.post(Uri.parse(url + '/login'),
        body: body, headers: apiHeaders);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      return responseBody['token'];
    }
    return "";
  }

  static Future<String> getBreakoutURL(String token) async {
    var client = http.Client();

    try {
      var body = jsonEncode(<String, dynamic>{'token': token});
      var response = await client.post(Uri.parse(url + "/getBreakoutURL"),
          headers: apiHeaders, body: body);
      var responseBody = json.decode(response.body);
      return responseBody["url"];
    } on Exception {
      rethrow;
    } finally {
      client.close();
    }
  }
}
