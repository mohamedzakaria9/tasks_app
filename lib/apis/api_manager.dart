import 'dart:convert';

import 'package:tasks_app/apis/api_constants.dart';
import 'package:tasks_app/apis/api_endPoints.dart';
import 'package:http/http.dart' as http;
import 'package:tasks_app/models/task_response.dart';

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
      Uri url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiEndpoints.tasks}??assignedTo=$userId",
      );
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response?> addTask(String token, TaskResponse task) async {
    try {
      Uri url = Uri.parse(ApiConstants.baseUrl + ApiEndpoints.tasks);
      print("this is the url : $url");
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "title": task.title,
          "description": task.description,
          "status": task.status,
          "priority": task.priority,
          "dueDate": task.dueDate,
          "assignedTo": task.assignedTo,
          "userId": task.assignedTo
        }),
      );
      return response;
    } catch (e) {
      return null;
    }
  }
}
