import 'dart:convert';

import 'package:advance_exam_app/screen/home/model/home_model.dart';
import 'package:http/http.dart' as http;
class APIHelper {
  Future<HomeModel?> homeAPICall(String edit) async {
    String apiLink =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyAEwmSOFGSx5H9D8UcKyXz9Ps5aeSZrNAk";
    var response = await http.post(Uri.parse(apiLink), headers: {
      "Content-Type": "application/json",
    }, body: {
      "contents": [
        {
          "parts": [
            {"text": edit}
          ]
        }
      ]
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return HomeModel.mapToModel(json);
    }
    return null;
  }
}


