import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService{

  static final apiHeaders = <String, String>{
    'Content-Type': 'application/json; charset=utf-8',
  };

  static Future<String> getBreakoutURL() async {
    var client = http.Client();

    try {
      var response;
      response = await client.get(Uri.parse("http://127.0.0.1:5000/getBreakoutURL"),
          headers: apiHeaders);
      response = response.body;
      var responseBody = json.decode(response);
      return responseBody["url"];
    } on Exception {
      rethrow;
    } finally {
      client.close();
    }
  }
}