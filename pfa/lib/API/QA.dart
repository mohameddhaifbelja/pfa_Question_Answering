import 'dart:convert';

import 'package:http/http.dart';


class QA{
  static String url="http://db34adc06b58.ngrok.io/";

  static send_question(question) async{
    Map<String, String> headrs = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    Map<String, String> body = {"question": question};

    Response response =
    await post(url, headers: headrs, body: json.encode(body));

  print(response);
    return response;


  }
}