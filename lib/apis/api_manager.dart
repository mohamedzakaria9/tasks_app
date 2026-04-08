import 'dart:convert';

import 'package:tasks_app/apis/api_constants.dart';
import 'package:tasks_app/apis/api_endPoints.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  static Future<http.Response?> login(String email, String password) async {
    try {
      Uri url = Uri.parse(ApiConstants.baseUrl + ApiEndpoints.login);
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<http.Response?> getTasks(String token, int userId) async {
    try {
      Uri url = Uri.parse("${ApiConstants.baseUrl}${ApiEndpoints.tasks}??assignedTo=$userId");
      print(url);
      print(token);
      print("this is before the response ");
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print("this is after the response");
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
