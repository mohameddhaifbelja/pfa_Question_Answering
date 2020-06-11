import 'dart:convert';

import 'package:http/http.dart' as http;


class QA{
  static String url="http://db34adc06b58.ngrok.io/";

  static Future<http.Response> send_question(question) async{
    Map<String, String> headrs = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    Map<String, String> body = {"question": question};

    return http.post(url, headers: headrs, body: json.encode(body));
/*
  print(response);
    return response;
*/

  }
}